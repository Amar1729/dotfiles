; extends

;; apply bash syntax highlighting to shell heredocs in Vagrantfiles
(
  (call
    method: (identifier) @_method (#eq? @_method "provision")
    arguments: (argument_list (string (string_content) @_str))
  )
  (heredoc_body (heredoc_content) @bash)
  (#eq? @_str "shell")
  (#offset! @bash 0 0 0 0)
)

