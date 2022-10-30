class SpecterProj extends RocketProj;

simulated function PostBeginPlay()
{
	Super(Projectile).PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {
		SmokeTrail = Spawn(class'AlterEgoTrail', self);
		//SmokeTrail.Skins[0] = Texture;
	}

	Velocity = Speed * Vector(Rotation); 
}

simulated function Destroyed()
{
    if (SmokeTrail != None)
    {
        SmokeTrail.mStartParticles = 12;
        SmokeTrail.mLifeRange[0] *= 2.0;
        SmokeTrail.mLifeRange[1] *= 2.0;
        SmokeTrail.mRegen = false;
    }
	Super(Projectile).Destroyed();
}

defaultproperties
{
     Speed=2450.000000
     MaxSpeed=2450.000000
     Damage=95.000000
     MomentumTransfer=60000.000000
     MyDamageType=Class'XWeapons.DamTypeRocket'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
     LightRadius=5.000000
     DrawType=DT_Sprite
     StaticMesh=StaticMesh'WeaponStaticMesh.LinkProjectile'
     CullDistance=7500.000000
     bDynamicLight=True
     AmbientSound=Sound'WeaponSounds.RocketLauncher.RocketLauncherProjectile'
     LifeSpan=10.000000
     Texture=Texture'tk_AlterEgoMonsters.WarLord.AlterEgoFlare'
     Skins(0)=Texture'tk_AlterEgoMonsters.WarLord.AlterEgoFlare'
     AmbientGlow=96
     Style=STY_Translucent
     FluidSurfaceShootStrengthMod=10.000000
     SoundVolume=255
     SoundRadius=100.000000
     bFixedRotationDir=True
     RotationRate=(Roll=50000)
     DesiredRotation=(Roll=30000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
