build-ctl: go-format go-vet
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o build/clearn clearn/main.go

go-format:
	go fmt ./...

go-vet:
	go vet ./...
