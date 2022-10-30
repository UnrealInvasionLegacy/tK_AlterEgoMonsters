class DecayAlpha extends Effects;

auto state Start
{
    simulated function Tick(float dt)
    {
        SetDrawScale(FMin(DrawScale + dt*12.0, 1.5));
        if (DrawScale >= 1.5)
        {
            GotoState('End');
        }
    }
}

state End
{
    simulated function Tick(float dt)
    {
        SetDrawScale(FMax(DrawScale - dt*12.0, 0.9));
        if (DrawScale <= 0.9)
        {
            GotoState('');
        }
    }
}

defaultproperties
{
     bTrailerSameRotation=True
     Physics=PHYS_Trailer
     Texture=Texture'tk_AlterEgoMonsters.Krall.DecayAlpha'
     DrawScale=1.200000
     DrawScale3D=(X=0.700000,Y=0.350000,Z=0.350000)
     Skins(0)=Texture'tk_AlterEgoMonsters.Krall.DecayAlpha'
     Style=STY_Translucent
     Mass=13.000000
}
