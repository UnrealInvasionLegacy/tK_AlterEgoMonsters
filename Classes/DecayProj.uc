class DecayProj extends Projectile;

var xEmitter Trail;
var texture TrailTex;
var bool bHitWater;
var int NumExtraRockets;
var xEmitter SmokeTrail;
var Effects Corona;

simulated function Destroyed()
{
    if ( SmokeTrail != None )
        SmokeTrail.mRegen = False;
    if ( Corona != None )
        Corona.Destroy();
    Super.Destroyed();
}

simulated function PostBeginPlay()
{
    if ( Level.NetMode != NM_DedicatedServer)
    {
        SmokeTrail = Spawn(class'DecayFlames',self);
        Corona = Spawn(class'DecayAlpha',self);
    }

    Velocity = speed * vector(Rotation);
    if (PhysicsVolume.bWaterVolume)
    {
        bHitWater = True;
        Velocity=0.6*Velocity;
    }
    Super.PostBeginPlay();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    if ( EffectIsRelevant(Location,false) )
        Spawn(class'LinkProjSparksYellow',,, HitLocation, rotator(HitNormal));
    PlaySound(Sound'WeaponSounds.BioRifle.BioRifleGoo2');
    Destroy();
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X, RefNormal, RefDir;

    if (Other == Instigator) return;
    if (Other == Owner) return;

    if (Other.IsA('xPawn') && xPawn(Other).CheckReflect(HitLocation, RefNormal, Damage*0.25))
    {
        if (Role == ROLE_Authority)
        {
            X = Normal(Velocity);
            RefDir = X - 2.0*RefNormal*(X dot RefNormal);
            Spawn(Class, Other,, HitLocation+RefDir*20, Rotator(RefDir));
        }
        Destroy();
    }
    else if ( Other.bProjTarget )
    {
        if ( Role == ROLE_Authority )
            Other.TakeDamage(Damage,Instigator,HitLocation,MomentumTransfer * Normal(Velocity),MyDamageType);
        Explode(HitLocation, vect(0,0,1));
    }
}

defaultproperties
{
     Speed=1325.000000
     MaxSpeed=1325.000000
     Damage=35.000000
     MomentumTransfer=25000.000000
     MyDamageType=Class'tk_AlterEgoMonsters.DamTypeDecay'
     ExplosionDecal=Class'XEffects.LinkBoltScorch'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=40
     LightSaturation=100
     LightBrightness=190.000000
     LightRadius=3.000000
     DrawType=DT_Sprite
     bDynamicLight=True
     AmbientSound=Sound'WeaponSounds.LinkGun.LinkGunProjectile'
     LifeSpan=8.000000
     Texture=Texture'tk_AlterEgoMonsters.Krall.AeDecayFireball'
     DrawScale=0.200000
     Skins(0)=Texture'tk_AlterEgoMonsters.Krall.AeDecayFireball'
     AmbientGlow=217
     Style=STY_Translucent
     SoundVolume=255
     SoundRadius=50.000000
     RotationRate=(Roll=80000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
