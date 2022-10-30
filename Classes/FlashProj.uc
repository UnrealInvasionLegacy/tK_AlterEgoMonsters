class FlashProj extends SkaarjProjectile;

simulated function PostBeginPlay()
{
    Super(Projectile).PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {
        SparkleTrail = Spawn(class'NecroTrial', self);
        SparkleTrail.Skins[0] = Texture;
    }

    Velocity = Speed * Vector(Rotation);
}

simulated function Destroyed()
{
    if (SparkleTrail != None)
    {
        SparkleTrail.mStartParticles = 10;
        SparkleTrail.mLifeRange[0] *= 1.8;
        SparkleTrail.mLifeRange[1] *= 1.8;
        SparkleTrail.mRegen = false;
    }
    Super.Destroyed();
}

simulated function DestroyTrails()
{
    if (SparkleTrail != None)
        SparkleTrail.Destroy();
}

defaultproperties
{
     Speed=1475.000000
     MaxSpeed=1475.000000
     Damage=40.000000
     DamageRadius=150.000000
     MomentumTransfer=70000.000000
     MyDamageType=Class'tk_AlterEgoMonsters.DamTypeFlash'
     ImpactSound=Sound'WeaponSounds.ShockRifle.ShockRifleExplosion'
     ExplosionDecal=Class'XEffects.LinkBoltScorch'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
     LightRadius=4.000000
     DrawType=DT_Sprite
     bDynamicLight=True
     AmbientSound=Sound'WeaponSounds.ShockRifle.ShockRifleProjectile'
     LifeSpan=10.000000
     Texture=Texture'tk_AlterEgoMonsters.Skaarj.AeFlashProj'
     DrawScale=0.200000
     Skins(0)=Texture'tk_AlterEgoMonsters.Skaarj.AeFlashProj'
     Style=STY_Translucent
     SoundVolume=29
     SoundRadius=65.000000
}
