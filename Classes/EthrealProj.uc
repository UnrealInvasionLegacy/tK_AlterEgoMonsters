class EthrealProj extends RocketProj;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrail = Spawn(class'EthrealFlames',self);
		Corona = Spawn(class'DecayAlpha',self);
	}

	Dir = vector(Rotation);
	Velocity = speed * Dir;
	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = True;
		Velocity=0.6*Velocity;
	}
	Super(Projectile).PostBeginPlay();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local PlayerController PC;

	PlaySound(sound'WeaponSounds.BExplosion3',,2.5*TransientSoundVolume);
    if ( EffectIsRelevant(Location,false) )
    {
    	Spawn(class'EthrealA',,,HitLocation + HitNormal*20,rotator(HitNormal));
    	PC = Level.GetLocalPlayerController();
		if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 5000 )
	        Spawn(class'ExplosionCrap',,, HitLocation + HitNormal*20, rotator(HitNormal));
//		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
//			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
    }

	BlowUp(HitLocation);
	Destroy();
}

defaultproperties
{
     Speed=1350.000000
     MaxSpeed=1350.000000
     Damage=90.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'tk_AlterEgoMonsters.DamTypeEthreal'
     ExplosionDecal=Class'tk_AlterEgoMonsters.NecroMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
     LightRadius=5.000000
     DrawType=DT_Sprite
     LifeSpan=8.000000
     Texture=Texture'tk_AlterEgoMonsters.Brute.AeEthrealProj'
     Skins(0)=Texture'tk_AlterEgoMonsters.Brute.AeEthrealProj'
}
