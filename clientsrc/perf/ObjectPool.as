package perf
{
    public class ObjectPool
    {
        private var pool:Array = [];
        private var factory:Function;

        public function ObjectPool(factory:Function)
        {
            this.factory = factory;
        }

        public function acquire():*
        {
            return pool.length > 0 ? pool.pop() : factory();
        }

        public function release(obj:*):void
        {
            if (obj == null) return;
            if (obj.parent != null) obj.parent.removeChild(obj);
            pool.push(obj);
        }
    }
}
