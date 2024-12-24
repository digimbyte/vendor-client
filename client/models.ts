interface WalletEvent {
	event: "wallet";
	contents: {
	  name: string;
	  hash: string;
	  division: number;
	  count: number;
	}[];
  }
  
  interface TradeAddEvent {
	event: "tradeadd";
	contents: {
	  trade_id: string;
	  stock: { name: string; hash: string; division: number; count: number };
	  trade: { name: string; hash: string; division: number; count: number };
	}[];
  }
  
  interface TradeRemoveEvent {
	event: "trade_remove";
	contents: {
	  trade_id: string;
	  stock: { name: string; hash: string; division: number; count: number };
	  trade: { name: string; hash: string; division: number; count: number };
	}[];
  }
  
  interface StockAddEvent {
	event: "stock_add";
	contents: {
	  trade_id: string;
	  stock: { name: string; hash: string; division: number; count: number };
	  trade: { name: string; hash: string; division: number; count: number };
	}[];
  }
  
  interface CreateStockEvent {
	event: "create_stock";
	contents: {
	  stock_remove: string;
	  stock: { name: string; hash: string; division: number; count: number };
	  trade: { name: string; hash: string; division: number; count: number };
	}[];
  }
  