/*** Server settings for the game ***/

// Coin cost to play
// todo: send at start
const COIN_COST = 50;

// Multiplier for outside bet winning
const OUTSIDE_MULTIPLIER = 2.0;

// Default starting jackpot
const BASE_JACKPOT = 120;

// Minimum amount the jackpot increases by per spin
const JACKPOT_INCREMENT_MIN = 5;

// Maximum amount the jackpot increases by per spin
const JACKPOT_INCREMENT_MAX = 20;

// Black (0) or Red (1) mapping for numeric values at index value - 1
local COLOR_MAP = [ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,
				    0, 1, 0, 1, 0, 1, 0, 1, 1, 0,
				    1, 0, 1, 0, 1, 0, 1, 0, 0, 1,
				    0, 1, 0, 1, 0, 1 ];

/*** DO NOT MODIFY BELOW THIS POINT ***/
local coinCount = 0;
local playerBetType = -1;
local playerBetValue = -1;
local jackpot = 0;

function define(script)
{
    script.Name = "roulette";
    script.Type = "WebGame";
    return 0;
}

function start(api, character, coins, out)
{
    coinCount = coins;

	// Set the starting jackpot
	jackpot = BASE_JACKPOT;

	api.SetResponse(out, "jackpot", jackpot.tostring());

    return 0;
}

function bet(api, session, params, out)
{
    local betType = params["betType"].tointeger();
	if(betType < -1 || betType > 1)
	{
        api.SetResponse(out, "error", "Invalid bet type supplied");
		return 0;
	}

    local betValue = params["betValue"].tointeger();
	if((betType == -1 && betValue != -1) ||
		(betType == 0 && (betValue < 0 || betValue > 37)) ||
		(betType == 1 && (betValue < 0 || betValue > 5)))
	{
        api.SetResponse(out, "error", "Invalid bet supplied");
		return 0;
	}

	if(betType != -1 && coinCount < COIN_COST)
	{
        api.SetResponse(out, "error", "Not enough coins");
		return 0;
	}

	playerBetType = betType;
    playerBetValue = betValue;

	return 0;
}

function spin(api, session, params, out)
{
	if(playerBetType == -1)
	{
        api.SetResponse(out, "error", "Spin is not valid until bet has been placed");
		return 0;
	}

	if(coinCount < COIN_COST)
	{
        api.SetResponse(out, "error", "Not enough coins");
		return 0;
	}

	local delta = -COIN_COST;

    local result = 0;

	// todo: randomize
    if(playerBetType == 0)
	{
		// Always win
		result = playerBetValue;
	}
	else
	{
		// Always 00
		result = 37;
	}

	local win = false;
    if(playerBetType == 0)
	{
		// Inside bet
		if(playerBetValue == result)
		{
			// Pay and reset jackpot
			api.SetResponse(out, "resultType", "JACKPOT");
			api.SetResponse(out, "coinsWon", jackpot.tostring());

			delta += jackpot;
			jackpot = BASE_JACKPOT;

			win = true;
		}
	}
	else
	{
		// Outside bet (ignores 0 and 00)
		if(result != 0 && result != 37)
		{
			switch(playerBetValue)
			{
				case 0:
					// Black
					win = COLOR_MAP[result - 1] == 0;
					break;
				case 1:
					// Red
					win = COLOR_MAP[result - 1] == 1;
					break;
				case 2:
					// Even
					win = result % 2 == 0;
					break;
				case 3:
					// Odd
					win = result % 2 == 1;
					break;
				case 4:
					// 1 to 18
					win = result >= 1 && result <= 18;
					break;
				case 5:
					// 19 to 36
					win = result >= 19 && result <= 36;
					break;
			}

			if(win)
			{
				local coinsWon = (COIN_COST * OUTSIDE_MULTIPLIER).tointeger();
				delta += coinsWon;

				api.SetResponse(out, "resultType", "WIN");
				api.SetResponse(out, "coinsWon", coinsWon.tostring());
			}
		}
	}


	if(!api.UpdateCoins(session, delta, true))
	{
        api.SetResponse(out, "error", "Coin update failed");
		return 0;
	}

    if(!win)
	{
		// Increase the jackpot
		// todo: randomize
		jackpot += JACKPOT_INCREMENT_MAX;

		api.SetResponse(out, "resultType", "LOSE");
	}

	coinCount = coinCount + delta;

	api.SetResponse(out, "spinResult", result.tostring());
	api.SetResponse(out, "coins", coinCount.tostring());
	api.SetResponse(out, "jackpot", jackpot.tostring());

    return 0;
}