;; extends

; apply sql syntax highlight to any var whose name matches QUERY_ or SQL_
(assignment
  left: (identifier) @_id (#match? @_id "QUERY_|SQL_")
  right: (string (string_content) @injection.content)
  (#set! injection.language "sql")
  (#offset! @injection.content 0 0 0 0)
  (#set! injection.include-children))

;; TODO?
; https://github.com/tree-sitter/tree-sitter/discussions/1577

; capture that highlights the _first_ string inside any function named foo.execute() as SQL
; (typically cur.execute())
(call
  function: (attribute attribute: (identifier) @id (#match? @id "execute"))
  arguments: (argument_list . (string (string_content) @injection.content))
  (#set! injection.language "sql")
  (#offset! @injection.content 0 0 0 0)
  (#set! injection.include-children))
