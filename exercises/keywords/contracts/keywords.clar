;; "block-height" returns an unsigned integer: current block height
;; "burn-block-height" returns an unsigned integer: current block height of the underlying burn blockchain (Bitcoin)
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-keywords#block-height
;; Fix the types below to perform the operation: <block-height> + 64
(+ block-height 64)

;; "tx-sender" returns the principal that sent the transaction.
;; "as-contract" function switches context to the contract's principal.
;; Contract principal can be returned as shown below:
(as-contract tx-sender)

;; "contract-caller" returns the principal that called the function.
;; If called via signed transaction, "tx-sender" = "contract-caller".
;; If called by another contract, "contract-caller" returns principal of the contract caller.
(print contract-caller)
