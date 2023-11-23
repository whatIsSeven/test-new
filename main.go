package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"runtime"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"os":      runtime.GOOS,
			"arch":    runtime.GOARCH,
			"version": runtime.Version(),
		})
	})
	_ = r.Run()
}
