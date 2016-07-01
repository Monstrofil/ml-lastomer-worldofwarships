package monstrofil.utils {
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    public class utils {

        public static function rotatePoint ( startPoint:Point, centerPoint:Point, currentAngleRad:Number ) :Point {
                var endPoint:Point = new Point ();
                var mx :Matrix  = new Matrix ();
                mx.translate(startPoint.x, startPoint.y);
                mx.rotate(currentAngleRad);
                mx.translate(centerPoint.x, centerPoint.y);
                endPoint = mx.transformPoint(endPoint);
                return endPoint;
            }

    }
    
}
