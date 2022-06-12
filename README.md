# ProtocolBufTools
version 3.15.8

直接允许批处理Gen.bat mac未写

在同级目录下建立Message\ProtoDefine

把proto文件放着，会在Message\ProtoCs生成文件

 

命令参考

```bash
protoc.exe --cpp_out=. addressbook.proto
protoc.exe --csharp_out=. addressbook.proto 
```

