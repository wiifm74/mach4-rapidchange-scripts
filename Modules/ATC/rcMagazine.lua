local inst = mc.mcGetInstance( "rcMagazine" )

local rcMagazine = {}

	local rcSpindle, Data, rc

	rcSpindle = require "rcSpindle"
	
	local function LoadData( )
		
		local data
		rc = mc.MERROR_NOERROR
		
		data = {
			[ 0 ] = { -- manual tool load/unload
				desc = "Manual toolchange position",
				mcPocket1 = 0,
				pockets = 1,
				p1 = { 					--g53 positions
					x = 2555.0,
					y = 600.0,
					z = 0.0
				},
				pOffset = { 			-- positive or negative for direction
					x = 0.0,
					y = 0.0,
					z = 0.0
				},
				lOffset = { 			-- positive or negative for direction. the distance a 70mm diameter tool needs to travel from pocket positions
					x = 0.0,			-- x distance to travel with tool in spindle AFTER loading
					y = 0.0,			-- y distance to travel with tool in spindle AFTER loading
					z = 0.0				-- z distance to travel with tool in spindle AFTER loading
				},
				spindle = rcSpindle.GetData( 0 )
			},
			[ 1 ] = {
				desc = "Sidewinder 16 pocket ATC",
				mcPocket1 = 1,
				pockets = 16,
				p1 = {
					x = 2505.25,
					y = 1204.1355,
					z = -184.0
				},
				pOffset = { 
					x = 0.0,
					y = -70,
					z = 0.0
				},
				lOffset = { 
					x = 50.5,
					y = 0.0,
					z = 7.5
				},
				spindle = rcSpindle.GetData( 1 )
			},
			[ 2 ] = {
				desc = "RapidChange 6 pocket ATC",
				mcPocket1 = 17,
				pockets = 6,
				p1 = {
					x = 1737.7,
					y = 1292.5,
					z = -196.0
				},
				pOffset = {
					x = 45.1,
					y = 0.0,
					z = 0.0
				},
				lOffset = {
					x = 0,
					y = 0,
					z = 7.5
				},
				spindle = rcSpindle.GetData( 2 )
			}
		}
		return data, rc
		
	end
	
	Data = LoadData( )
	
	local function GetMagazineInRange( i )
		
		rc = mc.MERROR_NOERROR
		return (i >= 0 and i <= #Data ), rc
		
	end

	function rcMagazine.GetMagazineIndices( p )
		
		local mIndex, pIndex
		rc = mc.MERROR_NOERROR
		
		Data, rc = LoadData( )	-- this may not be necessary, but should keep user settings up-to-date
		
		mIndex = 0
		pIndex = 1
		
		for i = #Data, 0, -1 do  --looping backwards here, so that if we don't find the magazine, we end up with a manual tool change
			if p >= Data[ i ].mcPocket1 and p < (Data[ i ].mcPocket1 + Data[ i ].pockets) then
				mIndex = i
				break
			end
		end
		
		pIndex = p - Data[ mIndex ].mcPocket1 + 1
		
		return mIndex, pIndex, rc
		
	end

	function rcMagazine.GetData( i )
		
		rc = mc.MERROR_NOERROR
		Data, rc = LoadData( )	-- this may not be necessary, but should keep user settings up-to-date
		
		if not GetMagazineInRange( i ) then
			rc = mc.MERROR_INVALID_ARG
			return Data [ 0 ], rc
		end
		
		return Data[ i ], rc
		
	end

return rcMagazine
