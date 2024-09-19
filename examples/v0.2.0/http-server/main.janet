(import circlet)

(defn myserver
 "A simple HTTP server" [request]
 {:status 200
  :headers {"Content-Type" "text/html"} :body "<!doctype html><html><body><h1>Hello.</h1></body></html>"})

(defn main [& args]
  (circlet/server myserver 8000))
