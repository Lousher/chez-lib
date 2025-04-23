(define TEMPLATE_DIRECTORY "/Users/song.lin/Desktop/MiracleBegin/Fun/chez-lib/azure-archive/template")
(define PROJECTS_DIRECTORY "/Users/song.lin/Library/Containers/56198FBC-176A-449B-9523-8DCCA112819F/Data/Documents/data/projects")

(define guid-generate
  (lambda () (get-line (car (process "uuidgen | tr 'A-F' 'a-f'")))))

(define-record-type project
  (nongenerative)
  (fields
   name (mutable entry) nodes (mutable exit))
  (protocol
   (lambda (new)
     (lambda (name)
       (new name #f (make-hashtable string-hash string=?) #f)))))
(define-record-type entry
  (nongenerative)
  (fields title header guid (mutable to))
  (protocol
   (lambda (new)
     (lambda (title header)
       (new title header "00000000-0000-0000-0000-000000000000" #f)))))
(define-record-type node
  (nongenerative)
  (fields type guid))
(define-record-type script
  (nongenerative)
  (parent node)
  (fields texts (mutable to))
  (protocol
   (lambda (pargs->new)
     (lambda ()
       ((pargs->new 'script (guid-generate)) '() #f)))))
(define-record-type option
  (nongenerative)
  (fields text (mutable to))
  (protocol
   (lambda (new)
     (lambda (text)
       (new text #f)))))
(define-record-type selection
  (nongenerative)
  (parent node)
  (fields (mutable options))
  (protocol
   (lambda (pargs->new)
     (lambda option-texts
	 ((pargs->new 'selection (guid-generate)) (map make-option option-texts))))))
(define-record-type text
  (nongenerative)
  (fields
   text
   (mutable popup)
   (mutable bgEffect)
   (mutable bgName)
   (mutable bgFriendlyName)
   (mutable sound)
   voice
   (mutable transition)
   (mutable bgmId)
   (mutable selectionGroup)
   (mutable additionalPrompt)
   (mutable characters)
   (mutable speaker)
   (mutable highlightedSlotNums)
   (mutable isDialogScript)
   (mutable placeText))
  (protocol
   (lambda (new)
     (lambda (text)
       (new text "" 0 1047754314 "BG_Black" "" (guid-generate) 0 999 0 "" '() 0 '() #t "")))))
(define-record-type character
  (nongenerative)
  (fields
   (mutable name)
   (mutable faceId)
   (mutable startingPos)
   (mutable endingPos)
   (mutable emoticon)
   (mutable action)
   (mutable effect)
   (mutable appear)
   (mutable shapeOverride))
  (protocol
   (lambda (new)
     (lambda (name)
       (new name "00" 0 0 -1 0 0 0 0)))))

(define character->json-file
