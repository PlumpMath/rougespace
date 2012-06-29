(in-package #:rougespace)

(defclass player (drawable object)
  ((symbol :initform 64)
   (can-share :initform t)
   (in-world :accessor player-in-world
	     :initform nil
	     :initarg :in-world)
   (pos :accessor player-pos
	:initform nil
	:initarg :pos)))

(defmethod player-move ((p Player) dx dy)
  (if (can-share (aref (world-array (player-in-world p)) 
	(+ (pos-x (player-pos p)) dx)
	(+ (pos-y (player-pos p)) dy)))
      (progn
       ;move player in world
      
       (remove p (aref (world-array (player-in-world p))
		       (pos-x (player-pos p))
		       (pos-y (player-pos p))))
       (cons (aref (world-array (player-in-world p))	
		   (+ (pos-x (player-pos p)) dx)
		   (+ (pos-y (player-pos p)) dy)) p)
       ;update player pos       
       (setf (pos-x (player-pos p)) 
	     (+ (pos-x (player-pos p)) dx))
       (setf (pos-y (player-pos p))
	     (+ (pos-y (player-pos p)) dy)) 
       ;return this list
       (list (+ (pos-x (player-pos p)) dx) 
	     (+ (pos-y (player-pos p)) dy))
       )
      ;else
      (list (pos-x (player-pos p)) 
	    (pos-y (player-pos p)))))

(defun can-share (cell)
  (every #'(lambda (n) (object-can-share n)) cell))
