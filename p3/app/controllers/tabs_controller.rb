class TabsController < ApplicationController
  def show2
    @tab_list = [
      { :all_tabs => [
          { :label => "Inventory", :url => "#dummy1"},
          { :label => "Order Information", :url => "#dummy2"},
          { :label => "Accounts", :url => "#dummy3"},
          { :label => "Shippers", :url => "#dummy4"},
          { :label => "Suppliers", :url => "#dummy5"},
        ], 
        :selected_tab => "Accounts",
      },
      { :all_tabs => [
          { :label => "AA", :url => "#dummy6"},
          { :label => "BB", :url => "#dummy7"},
          { :label => "CC", :url => "#dummy8"},
        ],
        :selected_tab => "AA",
      },
    ]
  end
end
