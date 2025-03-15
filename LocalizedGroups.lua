LocalizedGroups = LibStub ("AceAddon-3.0"):NewAddon ("LocalizedGroups", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local LocalizedGroups = LocalizedGroups

local f = CreateFrame ("frame", nil, UIParent)
f:RegisterEvent ("LFG_LIST_SEARCH_RESULTS_RECEIVED")

function LocalizedGroups:UpdateList()
	LFGListSearchPanel_UpdateResultList (LFGListFrame.SearchPanel)
	LFGListSearchPanel_UpdateResults (LFGListFrame.SearchPanel)
end

f:SetScript ("OnEvent", function (self, event, ...)
	LocalizedGroups:ScheduleTimer ("UpdateList", 1)
end)
 
 --> no more global calls
 local strsplit = strsplit
 local select = select
 local hooksecurefunc = hooksecurefunc
 
--> BRAZIL
	function LocalizedGroups:InstallHookBR()
		hooksecurefunc ("LFGListSearchEntry_Update", function (self) 
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(self.resultID)
			local LN1 = searchResultInfo1.leaderName
			local activityID1 = searchResultInfo1.activityID

			--searchResultInfo1.name
			--searchResultInfo1.comment

			if (LN1 and ( LN1:find ("Azralon") or LN1:find ("Nemesis") or LN1:find ("Gallywyx") or LN1:find ("Tol Barad") or LN1:find ("Goldrinn") or not select (2, strsplit ("-", LN1)))) then 
				local activityName = C_LFGList.GetActivityFullName(searchResultInfo1.activityIDs[1], nil, searchResultInfo1.isWarMode)
				
				self.ActivityName:SetText ("|cFFFFFF00[BR]|r " .. activityName)
				self.ActivityName:SetTextColor (0, 1, 0)
			end
		end)
	end

	function LocalizedGroups:ReplaceSortFuncBR()
		LFGListUtil_SortSearchResultsCB = function (id1, id2)
			
			local regionID = GetCurrentRegion()
			
			--brazil realms are under US region which has ID 1
			if (regionID ~= 1) then
				return
			end
			
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
			local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

			local numBNetFriends1 = searchResultInfo1.numBNetFriends
			local numCharFriends1 = searchResultInfo1.numCharFriends
			local numGuildMates1 = searchResultInfo1.numGuildMates
			local LN1 = searchResultInfo1.leaderName

			local numBNetFriends2 = searchResultInfo2.numBNetFriends
			local numCharFriends2 = searchResultInfo2.numCharFriends
			local numGuildMates2 = searchResultInfo2.numGuildMates
			local LN2 = searchResultInfo2.leaderName

			if (LN1 and ( LN1:find ("Azralon") or LN1:find ("Nemesis") or LN1:find ("Gallywyx") or LN1:find ("Tol Barad") or LN1:find ("Goldrinn") or not select (2, strsplit ("-", LN1)))) then 
				if (LN2 and ( LN2:find ("Azralon") or LN2:find ("Nemesis") or LN2:find ("Gallywyx") or LN2:find ("Tol Barad") or LN2:find ("Goldrinn") or not select (2, strsplit ("-", LN2)))) then 
					if ( numBNetFriends1 ~= numBNetFriends2 ) then
						return numBNetFriends1 > numBNetFriends2
					end

					if ( numCharFriends1 ~= numCharFriends2 ) then
						return numCharFriends1 > numCharFriends2
					end

					if ( numGuildMates1 ~= numGuildMates2 ) then
						return numGuildMates1 > numGuildMates2
					end
					
					return id1 < id2
				end
				
				return true
			end
			
			if (LN2 and ( LN2:find ("Azralon") or LN2:find ("Nemesis") or LN2:find ("Gallywyx") or LN2:find ("Tol Barad") or LN2:find ("Goldrinn") or not select (2, strsplit ("-", LN2)))) then 
				return false
			end

			--If one has more friends, do that one first
			if ( numBNetFriends1 ~= numBNetFriends2 ) then
				return numBNetFriends1 > numBNetFriends2
			end

			if ( numCharFriends1 ~= numCharFriends2 ) then
				return numCharFriends1 > numCharFriends2
			end

			if ( numGuildMates1 ~= numGuildMates2 ) then
				return numGuildMates1 > numGuildMates2
			end
			
			--If we aren't sorting by anything else, just go by ID
			return id1 < id2
			
		end
	end

--> LATIN
	function LocalizedGroups:InstallHookLA()
		hooksecurefunc ("LFGListSearchEntry_Update", function (self) 
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(self.resultID)
			local LN1 = searchResultInfo1.leaderName
			local activityID1 = searchResultInfo1.activityID
			
			if (LN1 and ( LN1:find ("Quel'Thalas") or LN1:find ("Drakkari") or LN1:find ("Ragnaros") or not select (2, strsplit ("-", LN1)))) then 
				local activityName = C_LFGList.GetActivityFullName(searchResultInfo1.activityIDs[1], nil, searchResultInfo1.isWarMode)
				
				self.ActivityName:SetText ("|cFFFFFF00[LA]|r " .. activityName)
				self.ActivityName:SetTextColor (0, 1, 0)
			end
		end)
	end

	function LocalizedGroups:ReplaceSortFuncLA()
		LFGListUtil_SortSearchResultsCB = function (id1, id2)
			
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
			local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

			local numBNetFriends1 = searchResultInfo1.numBNetFriends
			local numCharFriends1 = searchResultInfo1.numCharFriends
			local numGuildMates1 = searchResultInfo1.numGuildMates
			local LN1 = searchResultInfo1.leaderName

			local numBNetFriends2 = searchResultInfo2.numBNetFriends
			local numCharFriends2 = searchResultInfo2.numCharFriends
			local numGuildMates2 = searchResultInfo2.numGuildMates
			local LN2 = searchResultInfo2.leaderName
			local regionID = GetCurrentRegion()
			
			--LA realms are under US region which has ID 1, avoid issues with europe server name
			if (regionID ~= 1) then
				return
			end
			
			if (LN1 and ( LN1:find ("Quel'Thalas") or LN1:find ("Drakkari") or LN1:find ("Ragnaros") or not select (2, strsplit ("-", LN1)))) then 
				if (LN2 and ( LN2:find ("Quel'Thalas") or LN2:find ("Drakkari") or LN2:find ("Ragnaros") or not select (2, strsplit ("-", LN2)))) then 
					if ( numBNetFriends1 ~= numBNetFriends2 ) then
						return numBNetFriends1 > numBNetFriends2
					end

					if ( numCharFriends1 ~= numCharFriends2 ) then
						return numCharFriends1 > numCharFriends2
					end

					if ( numGuildMates1 ~= numGuildMates2 ) then
						return numGuildMates1 > numGuildMates2
					end
					
					return id1 < id2
				end
				
				return true
			end
			
			if (LN2 and ( LN2:find ("Quel'Thalas") or LN2:find ("Drakkari") or LN2:find ("Ragnaros") or not select (2, strsplit ("-", LN2)))) then 
				return false
			end

			--If one has more friends, do that one first
			if ( numBNetFriends1 ~= numBNetFriends2 ) then
				return numBNetFriends1 > numBNetFriends2
			end

			if ( numCharFriends1 ~= numCharFriends2 ) then
				return numCharFriends1 > numCharFriends2
			end

			if ( numGuildMates1 ~= numGuildMates2 ) then
				return numGuildMates1 > numGuildMates2
			end
			
			--If we aren't sorting by anything else, just go by ID
			return id1 < id2
			
		end
	end
	
--> OCEANIC
	function LocalizedGroups:InstallHookOC()
		hooksecurefunc ("LFGListSearchEntry_Update", function (self) 
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(self.resultID)
			local LN1 = searchResultInfo1.leaderName
			local activityID1 = searchResultInfo1.activityID

			if (LN1 and ( LN1:find ("Aman'Thul") or LN1:find ("Barthilas") or LN1:find ("Caelestrasz") or LN1:find ("Dath'Remar") or LN1:find ("Dreadmaul") or LN1:find ("Gundrak") or LN1:find ("Jubei'Thos") or LN1:find ("Khaz'goroth") or LN1:find ("Nagrand") or LN1:find ("Saurfang") or LN1:find ("Thaurissan") or LN1:find ("Frostmourne") or not select (2, strsplit ("-", LN1)))) then 
				local activityName = C_LFGList.GetActivityFullName(searchResultInfo1.activityIDs[1], nil, searchResultInfo1.isWarMode)
				
				self.ActivityName:SetText ("|cFFFFFF00[OC]|r " .. activityName)
				self.ActivityName:SetTextColor (0, 1, 0)
			

			end
		end)
	end

	function LocalizedGroups:ReplaceSortFuncOC()
		LFGListUtil_SortSearchResultsCB = function (id1, id2)

			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
			local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

			local numBNetFriends1 = searchResultInfo1.numBNetFriends
			local numCharFriends1 = searchResultInfo1.numCharFriends
			local numGuildMates1 = searchResultInfo1.numGuildMates
			local LN1 = searchResultInfo1.leaderName

			local numBNetFriends2 = searchResultInfo2.numBNetFriends
			local numCharFriends2 = searchResultInfo2.numCharFriends
			local numGuildMates2 = searchResultInfo2.numGuildMates
			local LN2 = searchResultInfo2.leaderName

			if (LN1 and ( LN1:find ("Aman'Thul") or LN1:find ("Barthilas") or LN1:find ("Caelestrasz") or LN1:find ("Dath'Remar") or LN1:find ("Dreadmaul") or LN1:find ("Gundrak") or LN1:find ("Jubei'Thos") or LN1:find ("Khaz'goroth") or LN1:find ("Nagrand") or LN1:find ("Saurfang") or LN1:find ("Thaurissan") or LN1:find ("Frostmourne") or not select (2, strsplit ("-", LN1)))) then 
				if (LN2 and ( LN2:find ("Aman'Thul") or LN2:find ("Barthilas") or LN2:find ("Caelestrasz") or LN2:find ("Dath'Remar") or LN2:find ("Dreadmaul") or LN2:find ("Gundrak") or LN2:find ("Jubei'Thos") or LN2:find ("Khaz'goroth") or LN2:find ("Nagrand") or LN2:find ("Saurfang") or LN2:find ("Thaurissan") or LN2:find ("Frostmourne") or not select (2, strsplit ("-", LN2)))) then 
					if ( numBNetFriends1 ~= numBNetFriends2 ) then
						return numBNetFriends1 > numBNetFriends2
					end

					if ( numCharFriends1 ~= numCharFriends2 ) then
						return numCharFriends1 > numCharFriends2
					end

					if ( numGuildMates1 ~= numGuildMates2 ) then
						return numGuildMates1 > numGuildMates2
					end
					
					return id1 < id2
				end
				
				return true
			end
			
			if (LN2 and ( LN2:find ("Aman'Thul") or LN2:find ("Barthilas") or LN2:find ("Caelestrasz") or LN2:find ("Dath'Remar") or LN2:find ("Dreadmaul") or LN2:find ("Gundrak") or LN2:find ("Jubei'Thos") or LN2:find ("Khaz'goroth") or LN2:find ("Nagrand") or LN2:find ("Saurfang") or LN2:find ("Thaurissan") or LN2:find ("Frostmourne") or not select (2, strsplit ("-", LN2)))) then 
				return false
			end

			--If one has more friends, do that one first
			if ( numBNetFriends1 ~= numBNetFriends2 ) then
				return numBNetFriends1 > numBNetFriends2
			end

			if ( numCharFriends1 ~= numCharFriends2 ) then
				return numCharFriends1 > numCharFriends2
			end

			if ( numGuildMates1 ~= numGuildMates2 ) then
				return numGuildMates1 > numGuildMates2
			end
			
			--If we aren't sorting by anything else, just go by ID
			return id1 < id2
			
		end
	end
	
--> FRENCH
	function LocalizedGroups:InstallHookFR()
		hooksecurefunc ("LFGListSearchEntry_Update", function (self) 
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(self.resultID)
			local LN1 = searchResultInfo1.leaderName
			local activityID1 = searchResultInfo1.activityID
			
			if (LN1 and ( LN1:find ("Hyjal") or LN1:find ("Arak-arahm") or LN1:find ("Temple noir") or LN1:find ("Arathi") or LN1:find ("Archimonde") or LN1:find ("Ysondre") or LN1:find ("Chants �ternels") or LN1:find ("Cho'gall") or LN1:find ("Confr�rie du Thorium") or LN1:find ("Conseil des Ombres") or LN1:find ("Culte de la Rive noire") or LN1:find ("Dalaran") or LN1:find ("Vol'jin") or LN1:find ("Drek'Thar") or LN1:find ("Eitrigg") or LN1:find ("Sinstralis") or LN1:find ("Eldre'Thalas") or LN1:find ("Naxxramas") or LN1:find ("Varimathras") or LN1:find ("Uldaman") or LN1:find ("Garona") or LN1:find ("Illidan") or LN1:find ("Kael'thas") or LN1:find ("Sargeras") or LN1:find ("Khaz Modan") or LN1:find ("Kirin Tor") or LN1:find ("Krasus") or LN1:find ("La Croisade �carlate") or LN1:find ("Rashgarroth") or LN1:find ("Les Clairvoyants") or LN1:find ("Les Sentinelles") or LN1:find ("Mar�cage de Zangar") or LN1:find ("Medivh") or LN1:find ("Ner'zhul") or LN1:find ("Throk'Feroth") or LN1:find ("Elune") or not select (2, strsplit ("-", LN1)))) then 
				local activityName = C_LFGList.GetActivityFullName(searchResultInfo1.activityIDs[1], nil, searchResultInfo1.isWarMode)
				
				self.ActivityName:SetText ("|cFFFFFF00[OC]|r " .. activityName)
				self.ActivityName:SetTextColor (0, 1, 0)
			end
		end)
	end

	function LocalizedGroups:ReplaceSortFuncFR()
		LFGListUtil_SortSearchResultsCB = function (id1, id2)
			
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
			local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

			local numBNetFriends1 = searchResultInfo1.numBNetFriends
			local numCharFriends1 = searchResultInfo1.numCharFriends
			local numGuildMates1 = searchResultInfo1.numGuildMates
			local LN1 = searchResultInfo1.leaderName

			local numBNetFriends2 = searchResultInfo2.numBNetFriends
			local numCharFriends2 = searchResultInfo2.numCharFriends
			local numGuildMates2 = searchResultInfo2.numGuildMates
			local LN2 = searchResultInfo2.leaderName

			if (LN1 and ( LN1:find ("Hyjal") or LN1:find ("Arak-arahm") or LN1:find ("Temple noir") or LN1:find ("Arathi") or LN1:find ("Archimonde") or LN1:find ("Ysondre") or LN1:find ("Chants �ternels") or LN1:find ("Cho'gall") or LN1:find ("Confr�rie du Thorium") or LN1:find ("Conseil des Ombres") or LN1:find ("Culte de la Rive noire") or LN1:find ("Dalaran") or LN1:find ("Vol'jin") or LN1:find ("Drek'Thar") or LN1:find ("Eitrigg") or LN1:find ("Sinstralis") or LN1:find ("Eldre'Thalas") or LN1:find ("Naxxramas") or LN1:find ("Varimathras") or LN1:find ("Uldaman") or LN1:find ("Garona") or LN1:find ("Illidan") or LN1:find ("Kael'thas") or LN1:find ("Sargeras") or LN1:find ("Khaz Modan") or LN1:find ("Kirin Tor") or LN1:find ("Krasus") or LN1:find ("La Croisade �carlate") or LN1:find ("Rashgarroth") or LN1:find ("Les Clairvoyants") or LN1:find ("Les Sentinelles") or LN1:find ("Mar�cage de Zangar") or LN1:find ("Medivh") or LN1:find ("Ner'zhul") or LN1:find ("Throk'Feroth") or LN1:find ("Elune") or not select (2, strsplit ("-", LN1)))) then 
				if (LN2 and ( LN2:find ("Hyjal") or LN2:find ("Arak-arahm") or LN2:find ("Temple noir") or LN2:find ("Arathi") or LN2:find ("Archimonde") or LN2:find ("Ysondre") or LN2:find ("Chants �ternels") or LN2:find ("Cho'gall") or LN2:find ("Confr�rie du Thorium") or LN2:find ("Conseil des Ombres") or LN2:find ("Culte de la Rive noire") or LN2:find ("Dalaran") or LN2:find ("Vol'jin") or LN2:find ("Drek'Thar") or LN2:find ("Eitrigg") or LN2:find ("Sinstralis") or LN2:find ("Eldre'Thalas") or LN2:find ("Naxxramas") or LN2:find ("Varimathras") or LN2:find ("Uldaman") or LN2:find ("Garona") or LN2:find ("Illidan") or LN2:find ("Kael'thas") or LN2:find ("Sargeras") or LN2:find ("Khaz Modan") or LN2:find ("Kirin Tor") or LN2:find ("Krasus") or LN2:find ("La Croisade �carlate") or LN2:find ("Rashgarroth") or LN2:find ("Les Clairvoyants") or LN2:find ("Les Sentinelles") or LN2:find ("Mar�cage de Zangar") or LN2:find ("Medivh") or LN2:find ("Ner'zhul") or LN2:find ("Throk'Feroth") or LN2:find ("Elune") or not select (2, strsplit ("-", LN2)))) then 
					if ( numBNetFriends1 ~= numBNetFriends2 ) then
						return numBNetFriends1 > numBNetFriends2
					end

					if ( numCharFriends1 ~= numCharFriends2 ) then
						return numCharFriends1 > numCharFriends2
					end

					if ( numGuildMates1 ~= numGuildMates2 ) then
						return numGuildMates1 > numGuildMates2
					end
					
					return id1 < id2
				end
				
				return true
			end
			
			if (LN2 and ( LN2:find ("Hyjal") or LN2:find ("Arak-arahm") or LN2:find ("Temple noir") or LN2:find ("Arathi") or LN2:find ("Archimonde") or LN2:find ("Ysondre") or LN2:find ("Chants �ternels") or LN2:find ("Cho'gall") or LN2:find ("Confr�rie du Thorium") or LN2:find ("Conseil des Ombres") or LN2:find ("Culte de la Rive noire") or LN2:find ("Dalaran") or LN2:find ("Vol'jin") or LN2:find ("Drek'Thar") or LN2:find ("Eitrigg") or LN2:find ("Sinstralis") or LN2:find ("Eldre'Thalas") or LN2:find ("Naxxramas") or LN2:find ("Varimathras") or LN2:find ("Uldaman") or LN2:find ("Garona") or LN2:find ("Illidan") or LN2:find ("Kael'thas") or LN2:find ("Sargeras") or LN2:find ("Khaz Modan") or LN2:find ("Kirin Tor") or LN2:find ("Krasus") or LN2:find ("La Croisade �carlate") or LN2:find ("Rashgarroth") or LN2:find ("Les Clairvoyants") or LN2:find ("Les Sentinelles") or LN2:find ("Mar�cage de Zangar") or LN2:find ("Medivh") or LN2:find ("Ner'zhul") or LN2:find ("Throk'Feroth") or LN2:find ("Elune") or not select (2, strsplit ("-", LN2)))) then 
				return false
			end

			--If one has more friends, do that one first
			if ( numBNetFriends1 ~= numBNetFriends2 ) then
				return numBNetFriends1 > numBNetFriends2
			end

			if ( numCharFriends1 ~= numCharFriends2 ) then
				return numCharFriends1 > numCharFriends2
			end

			if ( numGuildMates1 ~= numGuildMates2 ) then
				return numGuildMates1 > numGuildMates2
			end
			
			--If we aren't sorting by anything else, just go by ID
			return id1 < id2
			
		end
	end
	
--> ITALIAN
	function LocalizedGroups:InstallHookIT()
		hooksecurefunc ("LFGListSearchEntry_Update", function (self) 
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(self.resultID)
			local LN1 = searchResultInfo1.leaderName
			local activityID1 = searchResultInfo1.activityID
			
			if (LN1 and ( LN1:find ("Pozzo dell'Eternit�") or LN1:find ("Nemesis") or not select (2, strsplit ("-", LN1)))) then 
				local activityName = C_LFGList.GetActivityFullName(searchResultInfo1.activityIDs[1], nil, searchResultInfo1.isWarMode)
				
				self.ActivityName:SetText ("|cFFFFFF00[LA]|r " .. activityName)
				self.ActivityName:SetTextColor (0, 1, 0)
			end
		end)
	end

	function LocalizedGroups:ReplaceSortFuncIT()
		LFGListUtil_SortSearchResultsCB = function (id1, id2)
			
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
			local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

			local numBNetFriends1 = searchResultInfo1.numBNetFriends
			local numCharFriends1 = searchResultInfo1.numCharFriends
			local numGuildMates1 = searchResultInfo1.numGuildMates
			local LN1 = searchResultInfo1.leaderName

			local numBNetFriends2 = searchResultInfo2.numBNetFriends
			local numCharFriends2 = searchResultInfo2.numCharFriends
			local numGuildMates2 = searchResultInfo2.numGuildMates
			local LN2 = searchResultInfo2.leaderName

			if (LN1 and ( LN1:find ("Pozzo dell'Eternit�") or LN1:find ("Nemesis") or not select (2, strsplit ("-", LN1)))) then 
				if (LN2 and ( LN2:find ("Pozzo dell'Eternit�") or LN2:find ("Nemesis") or not select (2, strsplit ("-", LN2)))) then 
					if ( numBNetFriends1 ~= numBNetFriends2 ) then
						return numBNetFriends1 > numBNetFriends2
					end

					if ( numCharFriends1 ~= numCharFriends2 ) then
						return numCharFriends1 > numCharFriends2
					end

					if ( numGuildMates1 ~= numGuildMates2 ) then
						return numGuildMates1 > numGuildMates2
					end
					
					return id1 < id2
				end
				
				return true
			end
			
			if (LN2 and ( LN2:find ("Pozzo dell'Eternit�") or LN2:find ("Nemesis") or not select (2, strsplit ("-", LN2)))) then 
				return false
			end

			--If one has more friends, do that one first
			if ( numBNetFriends1 ~= numBNetFriends2 ) then
				return numBNetFriends1 > numBNetFriends2
			end

			if ( numCharFriends1 ~= numCharFriends2 ) then
				return numCharFriends1 > numCharFriends2
			end

			if ( numGuildMates1 ~= numGuildMates2 ) then
				return numGuildMates1 > numGuildMates2
			end
			
			--If we aren't sorting by anything else, just go by ID
			return id1 < id2
			
		end
	end
	
--> SPAIN
	function LocalizedGroups:InstallHookSP()
		hooksecurefunc ("LFGListSearchEntry_Update", function (self) 
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(self.resultID)
			local LN1 = searchResultInfo1.leaderName
			local activityID1 = searchResultInfo1.activityID
			
			if (LN1 and (LN1:find ("Dun Modr") or LN1:find ("Uldum") or LN1:find ("Colinas Pardas") or LN1:find ("C'Thun") or LN1:find ("Shen'dralar") or LN1:find ("Exodar") or LN1:find ("Los Errantes") or LN1:find ("Minahonda") or LN1:find ("Sanguino") or LN1:find ("Zul'jin") or LN1:find ("Tyrande") or not select (2, strsplit ("-", LN1)))) then 
				local activityName = C_LFGList.GetActivityFullName(searchResultInfo1.activityIDs[1], nil, searchResultInfo1.isWarMode)
				
				self.ActivityName:SetText ("|cFFFFFF00[LA]|r " .. activityName)
				self.ActivityName:SetTextColor (0, 1, 0)
			end
		end)
	end

	function LocalizedGroups:ReplaceSortFuncSP()
		LFGListUtil_SortSearchResultsCB = function (id1, id2)
			
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
			local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

			local numBNetFriends1 = searchResultInfo1.numBNetFriends
			local numCharFriends1 = searchResultInfo1.numCharFriends
			local numGuildMates1 = searchResultInfo1.numGuildMates
			local LN1 = searchResultInfo1.leaderName

			local numBNetFriends2 = searchResultInfo2.numBNetFriends
			local numCharFriends2 = searchResultInfo2.numCharFriends
			local numGuildMates2 = searchResultInfo2.numGuildMates
			local LN2 = searchResultInfo2.leaderName

			if (LN1 and ( LN1:find ("Dun Modr") or LN1:find ("Uldum") or LN1:find ("Colinas Pardas") or LN1:find ("C'Thun") or LN1:find ("Shen'dralar") or LN1:find ("Exodar") or LN1:find ("Los Errantes") or LN1:find ("Minahonda") or LN1:find ("Sanguino") or LN1:find ("Zul'jin") or LN1:find ("Tyrande") or not select (2, strsplit ("-", LN1)))) then 
				if (LN2 and ( LN2:find ("Dun Modr") or LN2:find ("Uldum") or LN2:find ("Colinas Pardas") or LN2:find ("C'Thun") or LN2:find ("Shen'dralar") or LN2:find ("Exodar") or LN2:find ("Los Errantes") or LN2:find ("Minahonda") or LN2:find ("Sanguino") or LN2:find ("Zul'jin") or LN2:find ("Tyrande") or not select (2, strsplit ("-", LN2)))) then 
					if ( numBNetFriends1 ~= numBNetFriends2 ) then
						return numBNetFriends1 > numBNetFriends2
					end

					if ( numCharFriends1 ~= numCharFriends2 ) then
						return numCharFriends1 > numCharFriends2
					end

					if ( numGuildMates1 ~= numGuildMates2 ) then
						return numGuildMates1 > numGuildMates2
					end
					
					return id1 < id2
				end
				
				return true
			end
			
			if (LN2 and ( LN2:find ("Dun Modr") or LN2:find ("Uldum") or LN2:find ("Colinas Pardas") or LN2:find ("C'Thun") or LN2:find ("Shen'dralar") or LN2:find ("Exodar") or LN2:find ("Los Errantes") or LN2:find ("Minahonda") or LN2:find ("Sanguino") or LN2:find ("Zul'jin") or LN2:find ("Tyrande") or not select (2, strsplit ("-", LN2)))) then 
				return false
			end

			--If one has more friends, do that one first
			if ( numBNetFriends1 ~= numBNetFriends2 ) then
				return numBNetFriends1 > numBNetFriends2
			end

			if ( numCharFriends1 ~= numCharFriends2 ) then
				return numCharFriends1 > numCharFriends2
			end

			if ( numGuildMates1 ~= numGuildMates2 ) then
				return numGuildMates1 > numGuildMates2
			end
			
			--If we aren't sorting by anything else, just go by ID
			return id1 < id2
			
		end
	end

--> RUSSIAN
	function LocalizedGroups:InstallHookRU()
		hooksecurefunc ("LFGListSearchEntry_Update", function (self) 
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(self.resultID)
			local LN1 = searchResultInfo1.leaderName
			local activityID1 = searchResultInfo1.activityID
			
			if (LN1 and (LN1:find ("Razuvious") or LN1:find ("Thermaplugg") or LN1:find ("Soulflayer") or LN1:find ("Ashenvale") or LN1:find ("Azuregos") or LN1:find ("Blackscar") or LN1:find ("Lich King") or LN1:find ("Howling Fjord") or LN1:find ("Grom") or LN1:find ("Greymane") or LN1:find ("Gordunni") or LN1:find ("Goldrinn") or LN1:find ("Booty Bay") or LN1:find ("Galakrond") or LN1:find ("Borean Tundra") or LN1:find ("Deathguard") or LN1:find ("Deathweaver") or LN1:find ("Eversong") or LN1:find ("Deepholm") or LN1:find ("Fordragon") or not select (2, strsplit ("-", LN1)))) then 
				local activityName = C_LFGList.GetActivityFullName(searchResultInfo1.activityIDs[1], nil, searchResultInfo1.isWarMode)
				
				self.ActivityName:SetText ("|cFFFFFF00[LA]|r " .. activityName)
				self.ActivityName:SetTextColor (0, 1, 0)
			end
		end)
	end

	function LocalizedGroups:ReplaceSortFuncRU()
		LFGListUtil_SortSearchResultsCB = function (id1, id2)
			
			local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
			local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

			local numBNetFriends1 = searchResultInfo1.numBNetFriends
			local numCharFriends1 = searchResultInfo1.numCharFriends
			local numGuildMates1 = searchResultInfo1.numGuildMates
			local LN1 = searchResultInfo1.leaderName

			local numBNetFriends2 = searchResultInfo2.numBNetFriends
			local numCharFriends2 = searchResultInfo2.numCharFriends
			local numGuildMates2 = searchResultInfo2.numGuildMates
			local LN2 = searchResultInfo2.leaderName

			if (LN1 and ( LN1:find ("Razuvious") or LN1:find ("Thermaplugg") or LN1:find ("Soulflayer") or LN1:find ("Ashenvale") or LN1:find ("Azuregos") or LN1:find ("Blackscar") or LN1:find ("Lich King") or LN1:find ("Howling Fjord") or LN1:find ("Grom") or LN1:find ("Greymane") or LN1:find ("Gordunni") or LN1:find ("Goldrinn") or LN1:find ("Booty Bay") or LN1:find ("Galakrond") or LN1:find ("Borean Tundra") or LN1:find ("Deathguard") or LN1:find ("Deathweaver") or LN1:find ("Eversong") or LN1:find ("Deepholm") or LN1:find ("Fordragon") or not select (2, strsplit ("-", LN1)))) then 
				if (LN2 and ( LN2:find ("Razuvious") or LN2:find ("Thermaplugg") or LN2:find ("Soulflayer") or LN2:find ("Ashenvale") or LN2:find ("Azuregos") or LN2:find ("Blackscar") or LN2:find ("Lich King") or LN2:find ("Howling Fjord") or LN2:find ("Grom") or LN2:find ("Greymane") or LN2:find ("Gordunni") or LN2:find ("Goldrinn") or LN2:find ("Booty Bay") or LN2:find ("Galakrond") or LN2:find ("Borean Tundra") or LN2:find ("Deathguard") or LN2:find ("Deathweaver") or LN2:find ("Eversong") or LN2:find ("Deepholm") or LN2:find ("Fordragon") or not select (2, strsplit ("-", LN2)))) then 
					if ( numBNetFriends1 ~= numBNetFriends2 ) then
						return numBNetFriends1 > numBNetFriends2
					end

					if ( numCharFriends1 ~= numCharFriends2 ) then
						return numCharFriends1 > numCharFriends2
					end

					if ( numGuildMates1 ~= numGuildMates2 ) then
						return numGuildMates1 > numGuildMates2
					end
					
					return id1 < id2
				end
				
				return true
			end
			
			if (LN2 and ( LN2:find ("Razuvious") or LN2:find ("Thermaplugg") or LN2:find ("Soulflayer") or LN2:find ("Ashenvale") or LN2:find ("Azuregos") or LN2:find ("Blackscar") or LN2:find ("Lich King") or LN2:find ("Howling Fjord") or LN2:find ("Grom") or LN2:find ("Greymane") or LN2:find ("Gordunni") or LN2:find ("Goldrinn") or LN2:find ("Booty Bay") or LN2:find ("Galakrond") or LN2:find ("Borean Tundra") or LN2:find ("Deathguard") or LN2:find ("Deathweaver") or LN2:find ("Eversong") or LN2:find ("Deepholm") or LN2:find ("Fordragon") or not select (2, strsplit ("-", LN2)))) then 
				return false
			end

			--If one has more friends, do that one first
			if ( numBNetFriends1 ~= numBNetFriends2 ) then
				return numBNetFriends1 > numBNetFriends2
			end

			if ( numCharFriends1 ~= numCharFriends2 ) then
				return numCharFriends1 > numCharFriends2
			end

			if ( numGuildMates1 ~= numGuildMates2 ) then
				return numGuildMates1 > numGuildMates2
			end
			
			--If we aren't sorting by anything else, just go by ID
			return id1 < id2
			
		end
	end
	
--> Make a Backup first
	function LocalizedGroups:CreateBackup()
		LocalizedGroups.original_sort_func = LFGListUtil_SortSearchResultsCB
	end

--> Region Realm List
	local brazil_realm_list = {
		["Azralon"] = true,
		["Nemesis"] =  true,
		["Goldrinn"] =  true,
		["Tol Barad"] =  true,
		["Gallywyx"] =  true,
	}

	local latin_realm_list = {
		["Quel'Thalas"] = true,
		["Drakkari"] = true,
		["Ragnaros"] = true,
	}
	
	local oceanic_realm_list = {
		["Aman'Thul"] = true,
		["Barthilas"] = true,
		["Caelestrasz"] = true,
		["Dath'Remar"] = true,
		["Dreadmaul"] = true,
		["Gundrak"] = true,
		["Jubei'Thos"] = true,
		["Khaz'goroth"] = true,
		["Nagrand"] = true,
		["Saurfang"] = true,
		["Thaurissan"] = true,
		["Frostmourne"] = true,
	}

	local french_realm_list = {
		["Les Sentinelles"] = true,
		["Mar�cage de Zangar"] = true,
		["Medivh"] = true,
		["Ner'zhul"] = true,
		["Throk'Feroth"] = true,
		["Elune"] = true,
		["Garona"] = true,
		["Illidan"] = true,
		["Kael'thas"] = true,
		["Sargeras"] = true,
		["Khaz Modan"] = true,
		["Kirin Tor"] = true,
		["Krasus"] = true,
		["La Croisade �carlate"] = true,
		["Rashgarroth"] = true,
		["Les Clairvoyants"] = true,
		["Culte de la Rive noire"] = true,
		["Dalaran"] = true,
		["Vol'jin"] = true,
		["Drek'Thar"] = true,
		["Eitrigg"] = true,
		["Sinstralis"] = true,
		["Eldre'Thalas"] = true,
		["Naxxramas"] = true,
		["Varimathras"] = true,
		["Uldaman"] = true,
		["Hyjal"] = true,
		["Arak-arahm"] = true,
		["Temple noir"] = true,
		["Arathi"] = true,
		["Archimonde"] = true,
		["Ysondre"] = true,
		["Chants �ternels"] = true,
		["Cho'gall"] = true,
		["Confr�rie du Thorium"] = true,
		["Conseil des Ombres"] = true,
	}

	local italian_realm_list = {
		["Pozzo dell'Eternit�"] = true,
		["Nemesis"] = true,
	}
	
	local spain_realm_list = {
		["Dun Modr"] = true,
		["Uldum"] = true,
		["Colinas Pardas"] = true,
		["C'Thun"] = true,
		["Shen'dralar"] = true,
		["Exodar"] = true,
		["Los Errantes"] = true,
		["Minahonda"] = true,
		["Sanguino"] = true,
		["Zul'jin"] = true,
		["Tyrande"] = true,
	}

	local russian_realm_list = {
		["Howling Fjord"] = true,
		["Grom"] = true,
		["Greymane"] = true,
		["Gordunni"] = true,
		["Goldrinn"] = true,
		["Booty Bay"] = true,
		["Galakrond"] = true,
		["Borean Tundra"] = true,
		["Deathguard"] = true,
		["Deathweaver"] = true,
		["Eversong"] = true,
		["Deepholm"] = true,
		["Fordragon"] = true,
		["Razuvious"] = true,
		["Thermaplugg"] = true,
		["Soulflayer"] = true,
		["Ashenvale"] = true,
		["Azuregos"] = true,
		["Blackscar"] = true,
		["Lich King"] = true,
	}

--> Install
	function LocalizedGroups:OnInitialize()

		LocalizedGroups:ScheduleTimer ("CreateBackup", 4)
		
		local realm = GetRealmName()
		
		if (brazil_realm_list [realm]) then
			LocalizedGroups:ScheduleTimer ("InstallHookBR", 5)
			LocalizedGroups:ScheduleTimer ("ReplaceSortFuncBR", 5.1)
			
		elseif (latin_realm_list [realm]) then
			LocalizedGroups:ScheduleTimer ("InstallHookLA", 5)
			LocalizedGroups:ScheduleTimer ("ReplaceSortFuncLA", 5.1)
			
		elseif (oceanic_realm_list [realm]) then
			LocalizedGroups:ScheduleTimer ("InstallHookOC", 5)
			LocalizedGroups:ScheduleTimer ("ReplaceSortFuncOC", 5.1)
			
		elseif (french_realm_list [realm]) then
			LocalizedGroups:ScheduleTimer ("InstallHookFR", 5)
			LocalizedGroups:ScheduleTimer ("ReplaceSortFuncFR", 5.1)
			
		elseif (italian_realm_list [realm]) then
			LocalizedGroups:ScheduleTimer ("InstallHookIT", 5)
			LocalizedGroups:ScheduleTimer ("ReplaceSortFuncIT", 5.1)

		elseif (spain_realm_list [realm]) then
			LocalizedGroups:ScheduleTimer ("InstallHookSP", 5)
			LocalizedGroups:ScheduleTimer ("ReplaceSortFuncSP", 5.1)
			
		elseif (russian_realm_list [realm]) then
			LocalizedGroups:ScheduleTimer ("InstallHookRU", 5)
			LocalizedGroups:ScheduleTimer ("ReplaceSortFuncRU", 5.1)
			
		end

		
		
	end