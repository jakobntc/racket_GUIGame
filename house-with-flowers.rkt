#lang racket
#|  To use this file, make sure it's in the same directory as your program,
    and use `(require "house-with-flowers.rkt")` and then your program
    can use the one exported identifier, `house-with-flowers`.

    NOTE: You can either download this file (save-to-disk), OR
          you can copy-paste it into DrRacket AND make sure that window's
               Language > Choose Language... > The Racket Language.
          ...If you're getting an error "#lang not defined", it's probably
          because you pasted the full-racket code into a blank DrRacket
          window whose language was set to a student-language.
          Just do the Choose Language to full racket, and save the file,
          and then it should be good.
 |#

(require 2htdp/image)
(provide house-with-flowers)

;; Some example of drawing simple pictures, using the image.ss library.
;; See:  http://docs.racket-lang.org/teachpack/2htdpimage.html
;; Ian Barland, 2012-Sep.


(define house-image (above (triangle 60 'solid 'saddleBrown)
                           (square 60 'solid 'darkGoldenRod)))


; one ellipse will serve as two petals:
(define petals2 (ellipse 50 10 200 'MediumSeaGreen))

; make-blossom: natnum -> image
; Return a flower-center, with 2*n petals.
;
(define (make-blossom n)
  (make-blossom-help n n))

; make-blossom-help: natnum, natnum -> image
; Return a flower with 2*i petals, out of 2*n total.
;
(define (make-blossom-help i n)
  (cond [(zero? i) empty-image]
        [(positive? i) (overlay (rotate (* i (/ 360 n 2)) petals2)
                                (make-blossom-help (sub1 i) n))]))



(define the-blossom (make-blossom 7))

; Add the stem, whose height is the same as the blossom:
(define flower
  (overlay/offset the-blossom
                  0  (/ (image-height the-blossom) 2)
                  (line 0 (image-height the-blossom) 'black)))


(define house-with-flowers
  (place-image
   (circle 30 'solid 'yellow)
   250  0
   ; house+flowers, enclosed in a scene:
   (overlay/align 'middle 'bottom 
                  (beside/align 'bottom flower flower house-image flower)
                  (empty-scene 250 180))))

  
;(save-svg-image house-with-flowers "house-with-flowers.svg")