--general categories to watch
CTATracker_HeroicWatch = true;
CTATracker_TWWatch = false;
CTATracker_LFRWatch = false;
--heroic roles to watch
CTATracker_HeroicTankWatch = false;
CTATracker_HeroicHealerWatch = false;
CTATracker_HeroicDPSWatch = false;
--timewalking roles to watch
CTATracker_TWTankWatch = false;
CTATracker_TWHealerWatch = false;
CTATracker_TWDPSWatch = false;
--LFR roles to watch
CTATracker_LFRTankWatch = false;
CTATracker_LFRHealerWatch = false;
CTATracker_LFRDPSWatch = false;
--Group checker for frame hiding
CTATracker_GroupStop = false;
--Current CTA status
CTATracker_CurrentlyHeroicCTA = false;
CTATracker_CurrentlyTWCTA = false;
CTATracker_CurrentlyLFRCTA = false;
--dungeon ids
CTATracker_HeroicID = 789;
CTATracker_TWID = {995,1146,744}; --WOTLK TW, don't know others
CTATracker_LFRID = {849,850,851,847,846,848,823,982,983,984,985,986};
CTATracker_LFRNames = {"WALL","ARCSAN","IMP","SLAG","FORGE","ASSEM","BLHAND","HELL","BLOOD","SHAD","DESTR","GATE"};
--frame
CTATracker_InnerFrame = nil;

--current cta display
CTATracker_CurrentCTA = {CTATracker_MainFrame};
CTATracker_NumberOfCTA = 1;
--current num of role icons
CTATracker_RoleIcons = {};
CTATracker_CurrentRoleIconNum = 0;

--Last important relativePoint
CTATracker_NextRelativePoint = nil;

--frame height
CTATracker_FrameHeight = 0;

--group and raid tracking
CTATracker_IsGrouped = false;

--play sound
CTATracker_PlaySound = false;
