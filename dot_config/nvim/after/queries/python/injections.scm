;; extends

; apply sql syntax highlight to any var whose name matches QUERY
(assignment
  left: (identifier) @_id (#match? @_id "QUERY")
  right: (string string_content: (string_content)) @sql
  (#offset! @sql 0 0 0 0))

;; TODO?
; https://github.com/tree-sitter/tree-sitter/discussions/1577
