class DementorProj extends RocketProj;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

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

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local PlayerController PC;

	PlaySound(sound'WeaponSounds.BExplosion3',,2.5*TransientSoundVolume);
    if ( EffectIsRelevant(Location,false) )
    {
    	Spawn(class'DementorExplosion',,,HitLocation + HitNormal*20,rotator(HitNormal));
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
     LifeSpan=10.000000
     Texture=Texture'tk_AlterEgoMonsters.WarLord.AlterEgoFlare'
     Skins(0)=Texture'tk_AlterEgoMonsters.WarLord.AlterEgoFlare'
}
