## Instructions for Cross Compiling

```
set GOOS=linux
set GOARCH=amd64
go build -o server main.go
```

```
curl -H "Content-Type: application/json" -X POST -d "{\"username\":\"[USRNAME]\",\"pwhash\":\"[PWHASH]\"}" http://localhost:8647/[reg or login]
curl -H "Content-Type: application/json" -X POST -d "{\"username\":\"[USRNAME]\",\"token\":\"[TOKEN]\"}" http://localhost:8647/auth
curl -F file=@[PATHTOFILE]"http://127.0.0.1:8647/up" 
```