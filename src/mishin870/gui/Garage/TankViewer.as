package mishin870.gui.Garage
{
   import alternativa.engine3d.core.Object3D;   
   import flash.display.Sprite;
   import flash.display.BitmapData;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.containers.ConflictContainer;
   import alternativa.engine3d.core.Camera3D;
   import flash.events.Event;
   import alternativa.engine3d.loaders.Parser3DS;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.core.View;
   import alternativa.engine3d.core.Sorting;
   
   public class TankViewer extends Sprite
   {
      
      [Embed(source = "garage.3DS", mimeType = "application/octet-stream")] private static const garageModelClass:Class;
      [Embed(source = "garage.jpg")] private static const garageTextureClass:Class;
       
      private var garageTexture:BitmapData = new garageTextureClass().bitmapData;
      
      private var garage:Mesh;
      
      private var gac:Object3DContainer = new Object3DContainer();
      
      private var tank:mishin870.gui.Garage.TankSkin = new mishin870.gui.Garage.TankSkin();
	  
	  private var container1:ConflictContainer = new ConflictContainer();
      
      private var camera:Camera3D = new Camera3D();
      
      private var controller:mishin870.gui.Garage.GarageObjectController;
      
      private var efEnab:Boolean = false;
      
      public function TankViewer(param1:MyTank)
      {
         super();
         this.parseGarage();
         this.camera.view = new View(100,100);
         this.camera.nearClipping = 1;
         this.camera.farClipping = 10000;
         this.camera.view.hideLogo();
         addChild(this.camera.view);
         this.container1.addChild(this.camera);
         this.garage.sorting = Sorting.DYNAMIC_BSP;
         this.container1.addChild(this.gac);
         this.gac.addChild(this.garage);
         this.camera.x = 400;
         this.camera.y = 400;
         this.camera.z = 500;
         this.camera.lookAt(0,0,0);
         this.efEnab = true;
         addEventListener(Event.ENTER_FRAME,this.ef);
         this.controller = new mishin870.gui.Garage.GarageObjectController(param1.inner,this.gac);
      }
      
      public function destroy() : void
      {
         this.efEnab = false;
         removeEventListener(Event.ENTER_FRAME,this.ef);
      }
      
      public function restore() : void
      {
         if(!this.efEnab)
         {
            addEventListener(Event.ENTER_FRAME,this.ef);
            this.efEnab = true;
         }
      }
      
      private function parseGarage() : void
      {
         var _loc1_:Parser3DS = new Parser3DS();
         _loc1_.parse(new garageModelClass());
         this.garage = _loc1_.objects[0] as Mesh;
         this.garage.setMaterialToAllFaces(new TextureMaterial(this.garageTexture));
      }
      
      private function ef(param1:Event) : void
      {
         this.camera.render();
      }
      
      public function res(param1:Number, param2:Number) : void
      {
         this.camera.view.width = param1;
         this.camera.view.height = param2;
      }
      
      public function loadTank(param1:String, param2:String, param3:String) : void
      {
         this.tank.addEventListener(Event.COMPLETE,this.tankLoaded);
         this.tank.loadTank(param1,param2,param3);
      }
      
      private function tankLoaded(param1:Event) : void
      {
         try
         {
            this.gac.removeChildAt(1);
         }
         catch(e:Error)
         {
         }
         this.gac.addChild(this.tank);
         this.tank.removeEventListener(Event.COMPLETE,this.tankLoaded);
      }
   }
}
