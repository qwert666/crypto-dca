DROP TABLE IF EXISTS "Users" CASCADE;
CREATE TABLE IF NOT EXISTS "Users" ("id" VARCHAR(60), "name" VARCHAR(255) NOT NULL UNIQUE, "password" VARCHAR(255) NOT NULL, "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey, array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) AS definition FROM pg_class t, pg_class i, pg_index ix, pg_attribute a WHERE t.oid = ix.indrelid AND i.oid = ix.indexrelid AND a.attrelid = t.oid AND t.relkind = 'r' and t.relname = 'Users' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey ORDER BY i.relname;
DROP TABLE IF EXISTS "Wallets" CASCADE;
CREATE TABLE IF NOT EXISTS "Wallets" ("id" VARCHAR(60), "name" VARCHAR(255) NOT NULL, "address" VARCHAR(255) NOT NULL, "local" BOOLEAN NOT NULL, "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL, "UserId" VARCHAR(60) REFERENCES "Users" ("id") ON DELETE SET NULL ON UPDATE CASCADE, PRIMARY KEY ("id"));
SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey, array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) AS definition FROM pg_class t, pg_class i, pg_index ix, pg_attribute a WHERE t.oid = ix.indrelid AND i.oid = ix.indexrelid AND a.attrelid = t.oid AND t.relkind = 'r' and t.relname = 'Wallets' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey ORDER BY i.relname;
DROP TABLE IF EXISTS "Coins" CASCADE;
CREATE TABLE IF NOT EXISTS "Coins" ("id" VARCHAR(60), "feeTolerance" VARCHAR(255) DEFAULT '0', "name" VARCHAR(255) NOT NULL, "code" VARCHAR(255) NOT NULL, "active" BOOLEAN DEFAULT false, "portfolioWeight" INTEGER DEFAULT 0, "localAmount" VARCHAR(255) DEFAULT '0', "exchangeAmount" VARCHAR(255) DEFAULT '0', "purchaseAmount" VARCHAR(255) DEFAULT '0', "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL, "UserId" VARCHAR(60) REFERENCES "Users" ("id") ON DELETE SET NULL ON UPDATE CASCADE, "localWalletId" VARCHAR(60) REFERENCES "Wallets" ("id") ON DELETE SET NULL ON UPDATE CASCADE, "exchangeWalletId" VARCHAR(60) REFERENCES "Wallets" ("id") ON DELETE SET NULL ON UPDATE CASCADE, PRIMARY KEY ("id"));
SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey, array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) AS definition FROM pg_class t, pg_class i, pg_index ix, pg_attribute a WHERE t.oid = ix.indrelid AND i.oid = ix.indexrelid AND a.attrelid = t.oid AND t.relkind = 'r' and t.relname = 'Coins' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey ORDER BY i.relname;
DROP TABLE IF EXISTS "Transactions" CASCADE;
CREATE TABLE IF NOT EXISTS "Transactions" ("id" VARCHAR(60), "startAmount" VARCHAR(255) DEFAULT '0', "endAmount" VARCHAR(255) DEFAULT '0', "success" BOOLEAN DEFAULT false, "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL, "UserId" VARCHAR(60) REFERENCES "Users" ("id") ON DELETE SET NULL ON UPDATE CASCADE, "startWalletId" VARCHAR(60) REFERENCES "Wallets" ("id") ON DELETE SET NULL ON UPDATE CASCADE, "endWalletId" VARCHAR(60) REFERENCES "Wallets" ("id") ON DELETE SET NULL ON UPDATE CASCADE, "startCoinId" VARCHAR(60) REFERENCES "Coins" ("id") ON DELETE SET NULL ON UPDATE CASCADE, "endCoinId" VARCHAR(60) REFERENCES "Coins" ("id") ON DELETE SET NULL ON UPDATE CASCADE, PRIMARY KEY ("id"));
SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey, array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) AS definition FROM pg_class t, pg_class i, pg_index ix, pg_attribute a WHERE t.oid = ix.indrelid AND i.oid = ix.indexrelid AND a.attrelid = t.oid AND t.relkind = 'r' and t.relname = 'Transactions' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey ORDER BY i.relname;
DROP TABLE IF EXISTS "Options" CASCADE;
CREATE TABLE IF NOT EXISTS "Options" ("id" VARCHAR(60), "name" VARCHAR(255) NOT NULL, "value" VARCHAR(255) NOT NULL, "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL, "UserId" VARCHAR(60) REFERENCES "Users" ("id") ON DELETE SET NULL ON UPDATE CASCADE, PRIMARY KEY ("id"));
SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey, array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) AS definition FROM pg_class t, pg_class i, pg_index ix, pg_attribute a WHERE t.oid = ix.indrelid AND i.oid = ix.indexrelid AND a.attrelid = t.oid AND t.relkind = 'r' and t.relname = 'Options' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey ORDER BY i.relname;
DROP TABLE IF EXISTS "Sessions" CASCADE;
CREATE TABLE IF NOT EXISTS "Sessions" ("sid" VARCHAR(32) , "expires" TIMESTAMP WITH TIME ZONE, "data" TEXT, "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL, PRIMARY KEY ("sid"));

INSERT INTO "Users" VALUES ('1', 'tomlagier', 'secretHash', '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00');
INSERT INTO "Users" VALUES ('2', 'marylagier', 'secretHash2', '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00');

INSERT INTO "Wallets" VALUES ('1', 'local BTC', 'abacadsf', true, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', 1);
INSERT INTO "Wallets" VALUES ('2', 'remote BTC', 'asdfdcvzdsfasd', false, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1');
INSERT INTO "Wallets" VALUES ('3', 'remote USDT', 'vczvsadf', false, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1');

INSERT INTO "Coins" VALUES ('1', '0', 'BitCoin', 'BTC', true, 50, '3.341', '0.023', '0.001', '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1', '1', '2');
INSERT INTO "Coins" VALUES ('2', '0', 'Tether', 'USDT', true, 0, '0', '524', '0', '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', 1, NULL, '3');

INSERT INTO "Options" VALUES ('1', 'invest_interval', '100', '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1');
INSERT INTO "Options" VALUES ('2', 'auto_rebalance', 'true', '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1');

INSERT INTO "Transactions" VALUES ('1', '500', '0.153', true, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1', '3', '2', '2', '1');
INSERT INTO "Transactions" VALUES ('2', '500', '0.167', true, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1', '3', '2', '2', '1');
INSERT INTO "Transactions" VALUES ('3', '500', '0.091', true, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1', '3', '2', '2', '1');
INSERT INTO "Transactions" VALUES ('4', '.472', '0.091', false, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1', '2', '1', '2', '2');
INSERT INTO "Transactions" VALUES ('5', '.472', '0.091', true, '2017-11-04 01:31:30.706+00', '2017-11-04 01:31:30.706+00', '1', '2', '1', '2', '2');