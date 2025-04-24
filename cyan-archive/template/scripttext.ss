(define-record-type scripttext
  (fields (mutable $type) (mutable text) (mutable popup)
    (mutable bgEffect) (mutable bgName) (mutable bgFriendlyName)
    (mutable sound) (mutable voice) (mutable transition)
    (mutable bgmId) (mutable selectionGroup)
    (mutable additionalPrompt) (mutable characters)
    (mutable speakerSlotNum) (mutable highlightedSlotNums)
    (mutable isDialogScript) (mutable placeText)))
