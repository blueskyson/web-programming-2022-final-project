Instructions for Cross Compiling

set GOOS=linux
set GOARCH=amd64
go build -o server main.go