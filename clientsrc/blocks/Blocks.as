package blocks
{
   import com.jiggmin.data.*;
   import flash.display.BitmapData;
   
   public class Blocks
   {
      
      public static var startBitmap:StartBitmap;
      
      public static var basic1Bitmap:Basic1Bitmap;
      
      public static var basic2Bitmap:Basic2Bitmap;
      
      public static var basic3Bitmap:Basic3Bitmap;
      
      public static var basic4Bitmap:Basic4Bitmap;
      
      public static var brickBitmap:BrickBitmap;
      
      public static var basic2Bitmap1:Basic2Bitmap;
      
      public static var basic2Bitmap2:Basic2Bitmap;
      
      public static var basic2Bitmap3:Basic2Bitmap;
      
      public static var basic2Bitmap4:Basic2Bitmap;
      
      public static var mineBitmap:MineBitmap;
      
      public static var itemBitmap:ItemBitmap;
      
      public static var iceBitmap:IceBitmap;
      
      public static var finishBitmap:FinishBitmap;
      
      public static var crumbleBitmap:CrumbleBitmap;
      
      public static var vanishBitmap:VanishBitmap;
      
      public static var moveBitmap:MoveBitmap;
      
      public static var waterBitmap:WaterBitmap;
      
      public static var rotateRightBitmap:RotateRightBitmap;
      
      public static var rotateLeftBitmap:RotateLeftBitmap;
      
      public static var pushBitmap:PushBitmap;
      
      public static var safetyNetBitmap:SafetyNetBitmap;
      
      public static var infiniteItemBitmap:InfiniteItemBitmap;
      
      public static var happyBitmap:HappyBitmap;
      
      public static var sadBitmap:SadBitmap;
      
      public static var heartBitmap:HeartBitmap;
      
      public static var timeBitmap:TimeBitmap;
      
      public static var customStatsBitmap:CustomStatsBitmap;
      
      public static var teleportBitmap:TeleportBitmap;
      
      public static var mudBitmap:MudBitmap;
      public static var freezeBitmap:FreezeTrapBitmap;
      public static var oneWayLeftBitmap:OneWayLeftBlock;
      public static var oneWayRightBitmap:OneWayRightBlock;
      public static var oneWayUpBitmap:OneWayUpBlock;
      public static var oneWayDownBitmap:OneWayDownBlock;
      public static var unsafeBitmap:UnsafeBlock;
       
      
      public function Blocks()
      {
         super();
      }
      
      public static function init() : *
      {
         startBitmap = new StartBitmap(30,30);
         basic1Bitmap = new Basic1Bitmap(30,30);
         basic2Bitmap = new Basic2Bitmap(30,30);
         basic3Bitmap = new Basic3Bitmap(30,30);
         basic4Bitmap = new Basic4Bitmap(30,30);
         brickBitmap = new BrickBitmap(30,30);
         basic2Bitmap1 = new Basic2Bitmap(30,30);
         basic2Bitmap2 = new Basic2Bitmap(30,30);
         basic2Bitmap3 = new Basic2Bitmap(30,30);
         basic2Bitmap4 = new Basic2Bitmap(30,30);
         mineBitmap = new MineBitmap(30,30);
         itemBitmap = new ItemBitmap(30,30);
         iceBitmap = new IceBitmap(30,30);
         finishBitmap = new FinishBitmap(30,30);
         crumbleBitmap = new CrumbleBitmap(30,30);
         vanishBitmap = new VanishBitmap(30,30);
         moveBitmap = new MoveBitmap(30,30);
         waterBitmap = new WaterBitmap(30,30);
         rotateRightBitmap = new RotateRightBitmap(30,30);
         rotateLeftBitmap = new RotateLeftBitmap(30,30);
         pushBitmap = new PushBitmap(30,30);
         safetyNetBitmap = new SafetyNetBitmap(30,30);
         infiniteItemBitmap = new InfiniteItemBitmap(30,30);
         happyBitmap = new HappyBitmap(30,30);
         sadBitmap = new SadBitmap(30,30);
         heartBitmap = new HeartBitmap(30,30);
         timeBitmap = new TimeBitmap(30,30);
         customStatsBitmap = new CustomStatsBitmap(30,30);
         teleportBitmap = new TeleportBitmap(30,30);
         mudBitmap = new MudBitmap(30,30);
         freezeBitmap = new FreezeTrapBitmap(30,30);
         oneWayLeftBitmap = new OneWayLeftBlock(30,30);
         oneWayRightBitmap = new OneWayRightBlock(30,30);
         oneWayUpBitmap = new OneWayUpBlock(30,30);
         oneWayDownBitmap = new OneWayDownBlock(30,30);
         unsafeBitmap = new UnsafeBlock(30,30);
      }
      
      public static function getBlock(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         if(param1 == Objects.BLOCK_BASIC1)
         {
            _loc2_ = basic1Bitmap;
         }
         else if(param1 == Objects.BLOCK_BASIC2)
         {
            _loc2_ = basic2Bitmap;
         }
         else if(param1 == Objects.BLOCK_BASIC3)
         {
            _loc2_ = basic3Bitmap;
         }
         else if(param1 == Objects.BLOCK_BASIC4)
         {
            _loc2_ = basic4Bitmap;
         }
         else if(param1 == Objects.BLOCK_BRICK)
         {
            _loc2_ = brickBitmap;
         }
         else if(param1 == Objects.BLOCK_CRUMBLE)
         {
            _loc2_ = crumbleBitmap;
         }
         else if(param1 == Objects.BLOCK_FINISH)
         {
            _loc2_ = finishBitmap;
         }
         else if(param1 == Objects.BLOCK_HAPPY)
         {
            _loc2_ = happyBitmap;
         }
         else if(param1 == Objects.BLOCK_ICE)
         {
            _loc2_ = iceBitmap;
         }
         else if(param1 == Objects.BLOCK_ITEM_INF)
         {
            _loc2_ = infiniteItemBitmap;
         }
         else if(param1 == Objects.BLOCK_ITEM)
         {
            _loc2_ = itemBitmap;
         }
         else if(param1 == Objects.BLOCK_MINE)
         {
            _loc2_ = mineBitmap;
         }
         else if(param1 == Objects.BLOCK_MOVE)
         {
            _loc2_ = moveBitmap;
         }
         else if(param1 == Objects.BLOCK_PUSH)
         {
            _loc2_ = pushBitmap;
         }
         else if(param1 == Objects.BLOCK_ROTATE_LEFT)
         {
            _loc2_ = rotateLeftBitmap;
         }
         else if(param1 == Objects.BLOCK_ROTATE_RIGHT)
         {
            _loc2_ = rotateRightBitmap;
         }
         else if(param1 == Objects.BLOCK_SAD)
         {
            _loc2_ = sadBitmap;
         }
         else if(param1 == Objects.BLOCK_SAFETY)
         {
            _loc2_ = safetyNetBitmap;
         }
         else if(param1 == Objects.BLOCK_VANISH)
         {
            _loc2_ = vanishBitmap;
         }
         else if(param1 == Objects.BLOCK_WATER)
         {
            _loc2_ = waterBitmap;
         }
         else if(param1 == Objects.BLOCK_ARROW_DOWN)
         {
            _loc2_ = basic2Bitmap1;
         }
         else if(param1 == Objects.BLOCK_ARROW_LEFT)
         {
            _loc2_ = basic2Bitmap3;
         }
         else if(param1 == Objects.BLOCK_ARROW_RIGHT)
         {
            _loc2_ = basic2Bitmap4;
         }
         else if(param1 == Objects.BLOCK_ARROW_UP)
         {
            _loc2_ = basic2Bitmap2;
         }
         else if(param1 == Objects.BLOCK_HEART)
         {
            _loc2_ = heartBitmap;
         }
         else if(param1 == Objects.BLOCK_START1 || param1 == Objects.BLOCK_START2 || param1 == Objects.BLOCK_START3 || param1 == Objects.BLOCK_START4)
         {
            _loc2_ = startBitmap;
         }
         else if(param1 == Objects.BLOCK_TIME)
         {
            _loc2_ = timeBitmap;
         }
         else if(param1 == Objects.BLOCK_CUSTOM_STATS)
         {
            _loc2_ = customStatsBitmap;
         }
         else if(param1 == Objects.BLOCK_TELEPORT)
         {
            _loc2_ = teleportBitmap;
         }
         else if(param1 == Objects.BLOCK_MUD)
         {
            _loc2_ = mudBitmap;
         }
         else if(param1 == Objects.BLOCK_FREEZE)
         {
            _loc2_ = freezeBitmap;
         }
         else if(param1 == Objects.BLOCK_ONE_WAY_LEFT)
         {
            _loc2_ = oneWayLeftBitmap;
         }
         else if(param1 == Objects.BLOCK_ONE_WAY_RIGHT)
         {
            _loc2_ = oneWayRightBitmap;
         }
         else if(param1 == Objects.BLOCK_ONE_WAY_UP)
         {
            _loc2_ = oneWayUpBitmap;
         }
         else if(param1 == Objects.BLOCK_ONE_WAY_DOWN)
         {
            _loc2_ = oneWayDownBitmap;
         }
         else if(param1 == Objects.BLOCK_UNSAFE)
         {
            _loc2_ = unsafeBitmap;
         }
         return _loc2_;
      }
   }
}
