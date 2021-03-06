(in-package #:rougespace)

;camera should not be moved out of range of the world
(defclass Camera ()
    ((size-x :accessor camera-size-x
		  :initform 80
		  :initarg :camera-size-x)
     (size-y :accessor camera-size-y
		  :initform 60
		  :initarg :camera-size-y)
     (pos    :accessor camera-pos
	     :initform (make-instance 'pos :x 20 :y 20)
	     :initarg :camera-pos)
     (limit-x :accessor camera-limit-x
	      :initform 300
	      :initarg :camera-limit-x)
     (limit-y :accessor camera-limit-y
	      :initform 300
	      :initarg :camera-limit-y)))

(defmethod camera-init ((c Camera))
  (tcod:console-init-root (camera-size-x c) 
			  (camera-size-y c) 
			  "Rouge Space" 
			  nil 
			  :renderer-sdl)
  (tcod:console-set-alignment tcod:*root* :left))

(defmethod camera-update ((c Camera) (p Player) (w World))
  (if 
  (setf (pos-x (camera-pos c)) (-  (pos-x (player-pos p))
				   (/ (camera-size-x c) 2) ))
  (setf (pos-y (camera-pos c)) (-  (pos-y (player-pos p))
				   (/ (camera-size-y c) 2)))))








