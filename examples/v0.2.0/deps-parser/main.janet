(import spork)
(import jpm)

(defn main [& args]
  (print (spork/json/encode (jpm/pm/load-project-meta (get args 1)))))
