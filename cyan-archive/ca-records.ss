(define guid-generate
  (lambda ()
    (get-line (car (process "uuidgen | tr 'A-F' 'a-f'")))))
(define x-generate (lambda () 0.0))
(define y-generate (lambda () 0.0))
(define-record-type vals
  (fields (mutable $type) (mutable $values))
  (protocol
    (lambda (new)
      (lambda ($type) (apply new
			     (list $type (make-vector 0)))))))

(define-record-type exit
  (fields (mutable $type) (mutable IsEnding) (mutable EndText)
    (mutable NeHeader) (mutable NeTitle) (mutable NeScriptDirty)
    (mutable Guid) (mutable ConnectionsTo) (mutable X)
    (mutable Y))
  (protocol
    (lambda (new)
      (lambda (IsEnding EndText NeHeader NeTitle)
        (apply
          new
          (list "ExitNodeData, Assembly-CSharp" IsEnding EndText NeHeader NeTitle (make-script) (guid-generate) (make-vals "System.Collections.Generic.List`1[[System.Guid, mscorlib]], mscorlib") (x-generate) (y-generate)))))))

(define-record-type character
  (fields (mutable $type) (mutable name) (mutable faceId)
    (mutable startingPos) (mutable endingPos) (mutable emoticon)
    (mutable action) (mutable effect) (mutable appear)
    (mutable shapeOverride))
  (protocol
    (lambda (new)
      (lambda (name startingPos endingPos emoticon
               action effect appear)
        (apply
          new
          (list $type name faceId startingPos endingPos emoticon
		action effect appear shapeOverride))))))

(define-record-type text
  (fields (mutable $type) (mutable text) (mutable popup)
    (mutable bgEffect) (mutable bgName) (mutable bgFriendlyName)
    (mutable sound) (mutable voice) (mutable transition)
    (mutable bgmId) (mutable selectionGroup)
    (mutable additionalPrompt) (mutable characters)
    (mutable speakerSlotNum) (mutable highlightedSlotNums)
    (mutable isDialogScript) (mutable placeText))
  (protocol
    (lambda (new)
      (lambda ($type text popup bgEffect bgName bgFriendlyName sound voice
               transition bgmId selectionGroup additionalPrompt characters
               speakerSlotNum highlightedSlotNums isDialogScript placeText)
        (apply
          new
          (list $type text popup bgEffect bgName bgFriendlyName sound voice
            transition bgmId selectionGroup additionalPrompt characters
            speakerSlotNum highlightedSlotNums isDialogScript
            placeText))))))

(define-record-type project
  (fields (mutable $type) (mutable ProjectName)
    (mutable PreviewBgName) (mutable PreviewHeader)
    (mutable PreviewTitle) (mutable nodes))
  (protocol
    (lambda (new)
      (lambda (ProjectName)
        (apply
          new
          (list "ProjectData, Assembly-CSharp" ProjectName 1047754314 #f #f nodes (make-vector 0)))))))

(define-record-type script
  (fields (mutable $type) (mutable Scripts) (mutable NodeName)
    (mutable Guid) (mutable ConnectionsTo) (mutable X)
    (mutable Y))
  (protocol
    (lambda (new)
      (lambda (NodeName)
        (apply
          new
          (list "ScriptNodeData, Assembly-CSharp"
		(make-vals "System.Collections.Generic.List`1[[ScriptData, Assembly-CSharp]], mscorlib") NodeName (guid-generate) (make-vals "System.Collections.Generic.List`1[[System.Guid, mscorlib]], mscorlib" (x-generate) (y-generate))))))))

(define-record-type selection
  (fields (mutable $type) (mutable selectionTexts)
    (mutable Guid) (mutable ConnectionsTo) (mutable X)
    (mutable Y))
  (protocol
    (lambda (new)
      (lambda (selectionTexts)
        (apply
          new
          (list "SelectionNodeData, Assembly-CSharp" (make-vals "System.Collections.Generic.List`1[[System.String, mscorlib]], mscorlib") (guid-generate) (make-vals "System.Collections.Generic.List`1[[System.Guid, mscorlib]], mscorlib") (x-generate) (y-generate)))))))

(define-record-type entry
  (fields (mutable $type) (mutable Title) (mutable Header)
    (mutable Guid) (mutable ConnectionsTo) (mutable X)
    (mutable Y))
  (protocol
    (lambda (new)
      (lambda ($type Title Header Guid ConnectionsTo X Y)
        (apply
          new
          (list $type Title Header Guid ConnectionsTo X Y))))))
