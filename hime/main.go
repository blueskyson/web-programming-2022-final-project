package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	bolt "go.etcd.io/bbolt"
)

type User struct {
	Username string `json:"username" binding:"required"`
	PwHash   string `json:"pwhash" binding:"required"`
}

type Session struct {
	Username string    `json:"username" binding:"required"`
	Expiry   time.Time `json:"expiry" binding:"required"`
}

type Auth struct {
	Username string `json:"username" binding:"required"`
	Token    string `json:"token" binding:"required"`
}

type PostHistory struct {
	History []string `json:"history" binding:"required"`
}

func login(c *gin.Context) {
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"msg": err.Error(),
		})
		return
	}
	defer db.Close()
	m := map[string]string{}
	c.Bind(&m)
	usr := []byte(m["username"])
	pw := []byte(m["pwhash"])
	err = db.View(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("user"))
		if b == nil {
			return fmt.Errorf("bucket is nil")
		}
		val := b.Get(usr)
		if val != nil {
			s := bytes.Equal(val, pw)
			if !s {
				return fmt.Errorf("Username Or Password Incorrect")
			} else {
				return nil
			}
		}
		return fmt.Errorf("Username Or Password Incorrect")
	})
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": err.Error(),
		})
		return
	}

	sessionStr := uuid.New().String()
	sessionID := []byte(sessionStr)
	expiry := time.Now().Add(time.Hour * 72)
	session := Session{m["username"], expiry}
	enc, err := json.Marshal(session)
	err = db.Update(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("active"))
		if b == nil {
			return fmt.Errorf("Bucket Not Exists")
		}
		err = b.Put(sessionID, enc)
		if err != nil {
			return fmt.Errorf("Session Failed")
		}
		return nil
	})

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"msg":   "Login Success",
		"token": sessionStr,
	})
}

func reg(c *gin.Context) {
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"msg": err.Error(),
		})
		return
	}
	defer db.Close()
	m := map[string]string{}
	c.Bind(&m)
	usr := []byte(m["username"])
	pw := []byte(m["pwhash"])
	err = db.View(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("user"))
		if b == nil {
			return fmt.Errorf("bucket is nil")
		}
		val := b.Get(usr)
		if val == nil {
			return nil
		}
		return fmt.Errorf("Username Taken")
	})
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": err.Error(),
		})
		return
	}
	err = db.Update(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("user"))
		if b == nil {
			return fmt.Errorf("Bucket Not Exists")
		}
		err = b.Put(usr, pw)
		if err != nil {
			return fmt.Errorf("Create User Failed")
		}
		return nil
	})
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"msg": "Create User Success",
	})
}

func up(c *gin.Context) {
	file, err := c.FormFile("file")
	if err != nil {
		c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	ext := filepath.Ext(file.Filename)
	if ext != ".png" && ext != ".jpg" && ext != ".jpeg" && ext != ".webp" && ext != ".gif" && ext != "./apng" {
		c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
			"error": "Type Not Supported",
		})
		return
	}
	saveFileName := uuid.New().String() + ext
	if err := c.SaveUploadedFile(file, "./uploads/"+saveFileName); err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"error": fmt.Sprintln("Unable to save file :", err),
		})
		return
	} else {
		c.JSON(http.StatusOK, gin.H{
			"msg": saveFileName,
		})
	}
	return
}

func auth(c *gin.Context) {
	m := map[string]string{}
	c.Bind(&m)
	usr := m["username"]
	token := m["token"]
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"msg": err.Error(),
		})
		return
	}
	defer db.Close()
	err = db.View(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("active"))
		if b == nil {
			return fmt.Errorf("bucket is nil")
		}
		val := b.Get([]byte(token))
		if val != nil {
			var s *Session
			err = json.Unmarshal(val, &s)
			if err != nil {
				return err
			}
			if s != nil {
				v := bytes.Equal([]byte(s.Username), []byte(usr))
				if v && s.Expiry.After(time.Now()) {
					return nil
				}
			}
		}
		return fmt.Errorf("Session Invalid")
	})
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"msg": "authenticated",
	})
}

func post(c *gin.Context) {
	var m map[string]interface{}
	c.Bind(&m)
	//trust-based
	usr := m["username"]
	if usr == nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": "Invalid User",
		})
		return
	}
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"msg": err.Error(),
		})
		return
	}
	defer db.Close()
	postID := uuid.New().String()
	err = db.Update(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("post"))
		if b == nil {
			return fmt.Errorf("bucket is nil")
		}
		err = b.Put([]byte(postID), []byte(fmt.Sprint(m)))
		if err != nil {
			return fmt.Errorf("Create Post Failed :%v", err)
		}

		b = t.Bucket([]byte("posthistory"))
		if b == nil {
			return fmt.Errorf("bucket is nil")
		}
		val := b.Get([]byte(fmt.Sprint(usr)))
		var ph *PostHistory
		if val != nil {
			err = json.Unmarshal(val, &ph)
			if err != nil {
				return err
			}
			ph.History = append(ph.History, postID)
		} else {
			ph = &PostHistory{History: []string{postID}}
		}
		enc, err := json.Marshal(ph)
		if err != nil {
			return err
		}
		err = b.Put([]byte(fmt.Sprintf("%v", usr)), []byte(enc))
		if err != nil {
			return fmt.Errorf("Create Post Failed :%v", err)
		}
		return nil
	})
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"msg": "Create Post Success",
	})
}

func view(c *gin.Context) {
	var m map[string]interface{}
	c.Bind(&m)
	//trust-based
	usr := m["username"]
	if usr == nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": "Invalid User",
		})
		return
	}
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"msg": err.Error(),
		})
		return
	}
	defer db.Close()
	err = db.View(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("posthistory"))
		if b == nil {
			return fmt.Errorf("bucket is nil")
		}
		val := b.Get([]byte(fmt.Sprint(usr)))
		if val != nil {
			c.Data(http.StatusOK, "application/json", val)
		}
		return fmt.Errorf("Invalid User")
	})
}

func viewpost(c *gin.Context) {
	var m map[string]interface{}
	c.Bind(&m)
	//trust-based
	pid := m["postid"]
	if pid == nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"msg": "Invalid Post ID",
		})
		return
	}
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"msg": err.Error(),
		})
		return
	}
	defer db.Close()
	err = db.View(func(t *bolt.Tx) error {
		b := t.Bucket([]byte("post"))
		if b == nil {
			return fmt.Errorf("bucket is nil")
		}
		val := b.Get([]byte(fmt.Sprint(pid)))
		if val != nil {
			c.Data(http.StatusOK, "application/json", val)
		}
		return fmt.Errorf("Invalid Post ID")
	})
}

func main() {
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		log.Fatal(err)
	}
	err = db.Update(func(t *bolt.Tx) error {
		_, err := t.CreateBucketIfNotExists([]byte("user"))
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}
	err = db.Update(func(t *bolt.Tx) error {
		_, err := t.CreateBucketIfNotExists([]byte("active"))
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}
	err = db.Update(func(t *bolt.Tx) error {
		_, err := t.CreateBucketIfNotExists([]byte("post"))
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}
	err = db.Update(func(t *bolt.Tx) error {
		_, err := t.CreateBucketIfNotExists([]byte("posthistory"))
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}
	db.Close()
	err = os.MkdirAll("./uploads", os.ModePerm)
	if err != nil {
		log.Fatal(err)
	}
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()
	r.MaxMultipartMemory = 16 << 20
	r.POST("/reg", reg)
	r.POST("/login", login)
	r.POST("/up", up)
	r.POST("/post", post)
	r.POST("/viewpost", viewpost)
	r.GET("/auth", auth)
	r.POST("/view", view)
	r.Run(":8647")
}
