package main

import (
	"net/http"

	"github.com/boltdb/bolt"
	"github.com/gin-gonic/gin"
)

//port 8647
type User struct {
	SessionID string `json:"session"`
	Username  string `json:"username"`
	Password  string `json:"password"`
}

func login(c *gin.Context) {
	//usr := c.PostForm("username")
	//pw := c.PostForm("password")
	c.JSON(http.StatusOK, gin.H{
		"result": "login not implemented",
	})
}

func reg(c *gin.Context) {
	//usr := c.PostForm("username")
	//pw := c.PostForm("password")
	c.JSON(http.StatusOK, gin.H{
		"result": "register not implemented",
	})

}

func main() {
	db, _ := bolt.Open("./user", 600, nil)
	defer db.Close()
	r := gin.Default()
	r.POST("/reg", reg)
	r.POST("/login", login)
	r.Run(":8647")
}
