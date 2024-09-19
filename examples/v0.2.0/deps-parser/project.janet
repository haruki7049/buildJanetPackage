(declare-project
  :name "deps-parser"
  :dependencies ["https://github.com/janet-lang/spork.git" "https://github.com/janet-lang/jpm.git"])

(declare-executable
  :name "deps-parser"
  :entry "main.janet"
  :install true)
