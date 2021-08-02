# io.cpp代码解析
* ReadProtoFromTextFile()解析filename文件，并把文件中的内容转换到`Message*`类型的对象`proto`中，
```c++
bool ReadProtoFromTextFile(const char* filename, Message* proto) {
  int fd = open(filename, O_RDONLY);
  CHECK_NE(fd, -1) << "File not found: " << filename;
  FileInputStream* input = new FileInputStream(fd);
  bool success = google::protobuf::TextFormat::Parse(input, proto);
  delete input;
  close(fd);
  return success;
}
```