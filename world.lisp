(in-package #:rougespace)

(defclass World ()
  ((size-x :accessor world-size-x
	 :initform 0
	 :initarg :size-x)
   (size-y :accessor world-size-y
	   :initform 0
	   :initarg :size-y)
   (default-thing-gen :accessor world-default-thing-gen
                 :initform '(make-instance 'Thing 
					  :name "dirt" 
					  :symbol 46
			                  :can-share t)
		 :initarg :default-thing-gen)
   (array :accessor world-array
		:initform nil
		:initarg :array)))

(defmethod draw-world ((w World) (c Camera))
  (loop for x from (pos-x (camera-pos c)) 
     to (+ (pos-x (camera-pos c)) (camera-size-x c) -1) do
       (loop for y from (pos-y (camera-pos c))
	    to (+ (pos-y (camera-pos c)) (camera-size-y c) -1) do
	    (loop for it in (aref (world-array w) x y) do
		 (draw it
		  (- x (pos-x (camera-pos c)))
		  (- y (pos-y (camera-pos c))))))))
 
(defmethod world-build ((w World) size-x size-y)
  (setf (world-size-x w) size-x)
  (setf (world-size-y w) size-y)
  (setf (world-array w) (make-array (list size-x size-y)))
  (loop for x from 0 to (- size-x 1) do
       (loop for y from 0 to (- size-y 1) do
	       (setf (aref (world-array w) x y) 
		     (list (eval (world-default-thing-gen w))))))
  (nconc (list *player*) (aref (world-array w) 
		      (pos-x (player-pos *player*)) 
		      (pos-y (player-pos *player*)))))


(defmethod world-spawn-objects-random ((w World) count)
	(loop for x from 0 to count do
	      (nconc (aref (world-array w) 
			    (random (world-size-x w))
			    (random (world-size-y w)))
		   (list (make-instance 'thing 
				  :name "tree" 
				  :symbol 50)))))

(defmethod world-edge-check ((w World) x y)
  (if (and (> (world-size-x w) x)
	   (> (world-size-y w) y)
	   (and (< 0 x) (< 0 y)))
      t
      nil))

