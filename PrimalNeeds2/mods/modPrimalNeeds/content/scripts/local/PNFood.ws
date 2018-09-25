struct PrimalFood
{
	var id: SItemUniqueId;
	var thirst: int;
	var hunger: int;
	var expire: int;
	var success : bool;
}

class FoodController
{
	public var playerItems: array < PrimalFood > ;
	
	public function Init() {
		InitPlayerInv();
	}
	
	public function Size() : int { return playerItems.Size(); }

	public function AddItem(item: SItemUniqueId, optional inv : CInventoryComponent)
	{
		var pfood: PrimalFood;
		
		if (!inv)
			pfood = ReworkOneFoodItem(item, thePlayer.GetInventory());
		else 
			pfood = ReworkOneFoodItem(item, inv);
		if (pfood.success)
			playerItems.PushBack(pfood);
	}

	public function GetStructItem(item: SItemUniqueId): PrimalFood
	{
		var i: int;
		var pfood : PrimalFood;

		for (i = 0; i < playerItems.Size(); i += 1)
		{
			if (playerItems[i].id == item)
				return playerItems[i];
		}
		pfood.success = false;
		return pfood;
	}

	public function RemoveItem(item: SItemUniqueId)
	{
		var pfood: PrimalFood;

		pfood = GetStructItem(item);
		if(pfood.success)
		{
			playerItems.Remove(pfood);
		}
	}

	public function GetExpire(item: SItemUniqueId): int
	{
		var pfood: PrimalFood;

		pfood = GetStructItem(item);
		if(pfood.success)
		{
			return pfood.expire;
		}
		return -1;
	}

	public function GetHunger(item: SItemUniqueId): int
	{
		var pfood: PrimalFood;

		pfood = GetStructItem(item);
		if(pfood.success)
		{
			return pfood.hunger;
		}
		return 0;
	}

	public function GetThirst(item: SItemUniqueId): int
	{
		var pfood: PrimalFood;

		pfood = GetStructItem(item);
		if(pfood.success)
		{
			return pfood.thirst;
		}
		return 0;
	}

	function UpdateToxicity(_inv: CInventoryComponent, itemId: SItemUniqueId): bool
	{
		var itemTox: float;
		var currTox: float;
		var maxTox: float;
		var pfood: PrimalFood;

		if (_inv.ItemHasTag(itemId, 'Alcohol') || _inv.GetItemName(itemId) == 'Raw meat')
		{
			pfood = GetStructItem(itemId);
			if(pfood.success)
			{
				itemTox = PN_GetFoodToxicity(itemId, _inv);
			}
		}
		currTox = thePlayer.GetStat(BCS_Toxicity);
		maxTox = thePlayer.GetStatMax(BCS_Toxicity);

		if (currTox + itemTox > maxTox)
		{
			GetWitcherPlayer().PN_SendToxicityTooHighMessage();
			return false;
		}
		if (itemTox > 0.f)
		{
			if (_inv.ItemHasTag(itemId, 'Drinks'))
			{
				thePlayer.abilityManager.DrainToxicity(itemTox * (-1));
			}
			else
			{
				thePlayer.abilityManager.GainStat(BCS_Toxicity, itemTox);
			}
		}
		return true;
	}

	function ReworkInvItems(inv: CInventoryComponent)
	{
		var items: array < SItemUniqueId > ;
		var i: int;

		items = inv.GetItemsByTag('Edibles');

		for (i = 0; i < items.Size(); i += 1)
		{
			ReworkOneFoodItem(items[i], inv);
		}
	}
	
	function InitPlayerInv() {
		var items: array < SItemUniqueId > ;
		var i: int;
		var inv : CInventoryComponent;
		
		inv = thePlayer.GetInventory();
		items = inv.GetItemsByTag('Edibles');
		for (i = 0; i < items.Size(); i += 1)
		{
			AddItem(items[i]);
		}
	}

	function ReworkOneFoodItem(item: SItemUniqueId, inv: CInventoryComponent): PrimalFood {
		var timeNow: int;
		var pfood: PrimalFood;

		if (!inv.ItemHasTag(item, 'Edibles')) {
			pfood.success = false;
			Log("PN: failed - not food");
			return pfood;
		}
		
		if (IsReworked(item)) {
			pfood.success = false;
			Log("PN: failed - already reworked");
			return pfood;
		}
		// base food
		timeNow = GameTimeToSeconds(theGame.GetGameTime()) / 60 / 60;
		pfood.id = item;
		pfood.success = true;
		if (inv.GetItemName(item) == 'Beauclair White')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');
			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Dijkstra Dry')
		{
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Erveluce')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Est Est')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');
			pfood.thirst = RandRange(50, 40);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Kaedwenian Stout')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Mettina Rose')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');
			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Local pepper vodka')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Redanian Lager')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Rivian Kriek')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Viziman Champion')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Apple')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			pfood.expire = 3;
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.thirst = RandRange(10, 5);
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Baked apple')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			pfood.expire = 5;
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.thirst = RandRange(10, 5);
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Banana')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			pfood.expire = 3;
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Bell pepper')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Blueberries')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.thirst = RandRange(10, 5);
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Bread')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Burned bread')
		{
			inv.PN_SetFoodQuality(item, '');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Bun')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Burned bun')
		{
			inv.PN_SetFoodQuality(item, '');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Candy')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Cheese')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chicken')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_1');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chicken leg')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Roasted chicken leg')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Roasted chicken')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chicken sandwich')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_1');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Grilled chicken sandwich')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Cucumber')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(10, 5);
			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Dried fruit')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Dried fruit and nuts')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Egg')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Fish')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_1');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Fried fish')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Gutted fish')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Fondue')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_1');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Grapes')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Ham sandwich')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Very good honey')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Honeycomb')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');

			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Fried meat')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Raw meat')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_1');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Cows milk')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(10, 5);
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Goats milk')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(10, 5);
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Mushroom')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Mutton curry')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Mutton leg')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Olive')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Onion')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Pear')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(10, 5);
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Pepper')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Plum')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Pork')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Grilled pork')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Potatoes')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Baked potato')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chips')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Raspberries')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(10, 5);
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Raspberry juice')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Strawberries')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(10, 5);
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Toffee')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Vinegar')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Butter Bandalura')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Apple juice')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Bottled water')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_3');

			pfood.thirst = RandRange(50, 40);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Dumpling')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		// Blood and Wine - new food
		if (inv.GetItemName(item) == 'Bourgogne chardonnay')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chateau mont valjean')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Bourgogne pinot noir')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Saint mathieu rouge')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Duke nicolas chardonnay')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(30, 15);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Uncle toms exquisite blanc')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chevalier adam pinot blanc reserve')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Prince john merlot')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Count var ochmann shiraz')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chateau de konrad cabernet')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Geralt de rivia')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'White Wolf')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Butcher of Blaviken')
		{

			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');

			pfood.thirst = RandRange(15, 10);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Pheasant gutted')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Tarte tatin')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Ratatouille')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Baguette camembert')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Crossaint honey')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');

			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Herb toasts')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Brioche')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Flamiche')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Camembert')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Chocolate souffle')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Pate chicken livers')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Confit de canard')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Baguette fish paste')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Fish tarte')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(40, 35);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Boeuf bourguignon')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Rillettes porc')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_1');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Onion soup')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(22, 16);
			pfood.thirst = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Ham roasted')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Tomato')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_4');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Cookies')
		{

			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Ginger Bread')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_5');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Magic Mushrooms')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			pfood.hunger = RandRange(22, 16);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Poison Apple')
		{
			inv.PN_SetFoodQuality(item, '');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Magic food')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_1');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Free roasted chicken leg')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_2');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Free nilfgaardian lemon')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(10, 5);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Sausages Mod')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_3');
			pfood.hunger = RandRange(16, 22);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Scrambled Eggs Mod')
		{
			inv.PN_SetFoodQuality(item, 'FoodEdibleQuality_3');
			inv.AddItemBaseAbility(item, 'expire_day_2');
			pfood.hunger = RandRange(30, 25);
			return pfood;
		}
		if (inv.GetItemName(item) == 'Tirnalia potion')
		{
			inv.PN_SetFoodQuality(item, 'BeverageQuality_1');
			pfood.hunger = RandRange(10, 6);
			return pfood;
		}
		
		pfood.success = false;
		Log( "'"+ inv.GetItemName(item) +"' is not among existing food");
		return pfood;
	}

	public function ExpireTheFood()
	{
		var items : array<SItemUniqueId>;
		var i : int;
		var currDay : int;
		var _inv : CInventoryComponent;
		
		_inv = thePlayer.GetInventory();
		
		items = _inv.GetItemsByTag('Edibles');
		
		for(i=items.Size()-1; i>=0; i-=1)
		{
			if ( PNGetItemAttributeValue(_inv.GetItemAttributeValue( items[i], 'expire' )) <= 0 && !_inv.ItemHasTag(items[i], 'no_expire') ) {
				_inv.AddItemTag( items[i], 'no_expire');
			}
			
			if (!_inv.ItemHasTag( items[i], 'no_expire' )) 
			{
				
				currDay = PNGetItemAttributeValue(_inv.GetItemAttributeValue( items[i], 'expire' ));

				switch(currDay) {
					case 5:
						_inv.RemoveItemBaseAbility(items[i], 'expire_day_5');
						_inv.AddItemBaseAbility(items[i], 'expire_day_4');
						break;
					case 4:
						_inv.RemoveItemBaseAbility(items[i], 'expire_day_4');
						_inv.AddItemBaseAbility(items[i], 'expire_day_3');
						break;
					case 3:
						_inv.RemoveItemBaseAbility(items[i], 'expire_day_3');
						_inv.AddItemBaseAbility(items[i], 'expire_day_2');
						break;
					case 2:
						_inv.RemoveItemBaseAbility(items[i], 'expire_day_2');
						_inv.AddItemBaseAbility(items[i], 'expire_day_1');
						break;
					case 1:
						_inv.RemoveItemBaseAbility(items[i], 'expire_day_1');
						_inv.AddItemBaseAbility(items[i], 'expire_day_0');
						break;
					default: break;
				}
				
				currDay = currDay - 1;
				
				if (currDay <= 0) 
				{
					_inv.RemoveItem( items[i], _inv.GetItemQuantity( items[i] ));
				}
			}
		}
	}
	
	public function IsReworked( item : SItemUniqueId ) : bool {
		var pfood : PrimalFood;
		pfood = GetStructItem( item );
		return pfood.success;
	}
}

function PN_GetFoodToxicity(item: SItemUniqueId, inv: CInventoryComponent): float
{
	if (!inv.ItemHasTag(item, 'Alcohol'))
		return 30;
	else if (inv.GetItemName(item) == 'Kaedwenian Stout'
		 || inv.GetItemName(item) == 'Mettina Rose'
		 || inv.GetItemName(item) == 'Local pepper vodka'
		 || inv.GetItemName(item) == 'Redanian Lager'
		 || inv.GetItemName(item) == 'Rivian Kriek'
		 || inv.GetItemName(item) == 'Viziman Champion')
		return 10;
	else
		return 20;
}