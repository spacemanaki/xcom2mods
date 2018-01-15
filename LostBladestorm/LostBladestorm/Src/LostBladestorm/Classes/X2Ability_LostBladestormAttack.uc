class X2Ability_LostBladestormAttack extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	Templates.AddItem(CreateLostBladestormAttack());
	Templates.AddItem(CreateLostBladestorm());
	return Templates;
}

static function X2AbilityTemplate CreateLostBladestorm()
{
	local X2AbilityTemplate Template;
	Template = PurePassive('LostBladestorm', "img:///UILibrary_PerkIcons.UIPerk_bladestorm", false, 'eAbilitySource_Perk');
	Template.AdditionalAbilities.AddItem('LostBladestormAttack');
	return Template;
}

static function X2DataTemplate CreateLostBladestormAttack()
{
	local X2AbilityTemplate Template;
	local X2Condition_LostBladestormRange RangeCondition;
	local X2Condition_UnitDoesNotHaveBladestorm ExcludeOtherBladestormCondition;
	Template = class'X2Ability_RangerAbilitySet'.static.BladestormAttack('LostBladestormAttack');

	/* necessary to limit range to 1 tile */
	RangeCondition = new class'X2Condition_LostBladestormRange';
	Template.AbilityTargetConditions.AddItem(RangeCondition);

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_escape";
	Template.Hostility = eHostility_Offensive;
//	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
//	Template.MergeVisualizationFn = LostAttack_MergeVisualization;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.CustomFireAnim = 'FF_Melee';
	Template.CinescriptCameraType = "Lost_Attack";

	/* do not trigger for units with bladestorm, gets game in a bugged state */
	ExcludeOtherBladestormCondition = new class'X2Condition_UnitDoesNotHaveBladestorm';
	Template.AbilityTargetConditions.AddItem(ExcludeOtherBladestormCondition);

	return Template;
}
