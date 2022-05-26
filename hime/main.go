package main

import (
	"bytes"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	bolt "go.etcd.io/bbolt"
)

type User struct {
	Username string `json:"username" binding:"required"`
	PwHash   string `json:"pwhash" binding:"required"`
}

func login(c *gin.Context) {
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
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
	c.JSON(http.StatusOK, gin.H{
		"msg":   "Login Success",
		"token": "not implemented",
	})
}

func reg(c *gin.Context) {
	db, err := bolt.Open("./AIO.db", 0666, nil)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
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
	db.Close()
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()
	r.POST("/reg", reg)
	r.POST("/login", login)
	r.Run(":8647")
}
