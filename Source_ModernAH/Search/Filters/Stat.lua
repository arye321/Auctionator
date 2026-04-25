Auctionator.Search.Filters.StatMixin = CreateFromMixins(Auctionator.Search.Filters.BlankFilterMixin)

function Auctionator.Search.Filters.StatMixin:Init(tracker, browseResult, statKey)
  Auctionator.Search.Filters.BlankFilterMixin.Init(self, tracker, browseResult)

  self.statKey = statKey
  if self.statKey == nil or self.statKey == "" then
    self:Pass()
    return
  end

  local item = Item:CreateFromItemLink(self.browseResult.itemLink)
  item:ContinueOnItemLoad(function()
    local stats = GetItemStats(self.browseResult.itemLink)
    if stats and stats[self.statKey] ~= nil then
      self:Pass()
    else
      self:Fail()
    end
  end)
end
