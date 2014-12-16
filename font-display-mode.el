
(eval-when-compile
  (require 'cl))

(require 'regexp-opt)
(require 'faces)


(defgroup font-display nil
  "Show font names written on the buffer in those fonts"
  :tag "font-display"
  :group 'help)


(defvar font-display-font-lock-keywords
  `((,(regexp-opt  (font-family-list) ) 
     (0 (font-display-by-name)))) "fonts to display" )

(defun font-display-by-name ()
  (put-text-property
   (match-beginning 0) (match-end 0)
   'face (list :family (match-string-no-properties 0) )))


(defun font-display-turn-on ()
  "Turn on font-display-mode."
  (font-lock-add-keywords nil
                          font-display-font-lock-keywords))

(defun font-display-turn-off ()
  "Turn off font-display-mode."
  (font-lock-remove-keywords
   nil
   `(,@font-display-font-lock-keywords)))

;;;###autoload
(define-minor-mode font-display-mode
  "Show font names written on the buffer in those fonts"
  :lighter " Font"
  (progn
    (if font-display-mode
        (font-display-turn-on)
      (font-display-turn-off))))


(provide 'font-display-mode)


