(declare-project
  :name "http-server"
  :dependencies ["https://github.com/janet-lang/circlet.git"])

(declare-executable
  :name "http-server"
  :entry "main.janet"
  :install true)
