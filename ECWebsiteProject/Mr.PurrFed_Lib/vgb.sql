-- DROP DATABASE IF EXISTS `test`;

-- CREATE DATABASE `test`  DEFAULT CHARSET=utf8;
-- USE `vgb`;

-- CREATE TABLE `customers` (
--   `id` char(10) NOT NULL,
--   `email` varchar(60) NOT NULL,
--   `name` varchar(40) NOT NULL,
--   `password` varchar(20) NOT NULL,
--   `phone` varchar(20) NOT NULL,
--   `gender` char(1) DEFAULT NULL,
--   `birthday` date DEFAULT NULL,
--   `address` varchar(80) DEFAULT '',
--   `married` tinyint(4) DEFAULT '0',
--   `blood_type` varchar(2) DEFAULT NULL,
--   `class_type` varchar(20) NOT NULL DEFAULT 'Customer',
--   `discount` INT NOT NULL DEFAULT 0,
--   
-- PRIMARY KEY (`id`,`email`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 
-- INSERT INTO customers(id,name,password,phone,gender,birthday,email)
-- VALUES('A123456789','黃聖釣','123456','0987654321',
--         'M','1990-02-12','snow666@gmail.com');
-- 
-- INSERT INTO customers
-- (id,email,name,password,phone,gender,
-- birthday,address,married,blood_type,class_type,discount)
--     VALUES('A987654321','wei.waa@gmail.com','魏汝萱','123466','0989778654',
-- 'F','1990-09-06','台北市復興北路99號8樓',true,'B','Customer',0);
-- 
-- INSERT INTO customers
-- (id,email,name,password,phone,gender,
-- birthday,address,married,blood_type,class_type,discount)
-- VALUES('H256185672','chenjing0303@yahoo.com.tw','陳書仙','125377','0937263541',
-- 'F','1997-03-03','桃園市桃園區中正路178號5樓',false,'B','VIP',15);
-- 
-- CREATE TABLE `products` (
--   `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
--   `name` VARCHAR(60) NOT NULL,
--   `unit_price` DOUBLE NOT NULL,
--   `stock` INT UNSIGNED NOT NULL,
--   `description` VARCHAR(200) NULL,
--   `photo_url` VARCHAR(200) NULL,
--   `class_type` VARCHAR(45) NOT NULL DEFAULT 'Product',
--   `discount` INT(2) UNSIGNED DEFAULT 0,
--    PRIMARY KEY (`id`),
--   UNIQUE KEY `email_UNIQUE` (`email`)
-- ) 
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8;
-- 
-- INSERT INTO products
-- (id,name, unit_price,stock,description,photo_url,class_type,discount)
-- VALUES('好味貓漢堡 海味鮮蝦 單一口味 多入',269,10,
-- '無穀超低碳水、豐富水分攝取、堅持新鮮製作，給您的毛小孩最好的照顧。',
-- 'https://shoplineimg.com/58a81a0d72fdc0ec2700333f/5ae4571759d52418d2001073/2000x.webp?source_format=jpg',
-- 'Product',0);
-- 
-- INSERT INTO products
-- (id,name, unit_price,stock,description,photo_url,class_type,discount)
-- VALUES('好味貓漢堡 鮮嫩香雞 單一口味 多入',269,10,
-- '無穀超低碳水、豐富水分攝取、堅持新鮮製作，給您的毛小孩最好的照顧。',
-- 'https://shoplineimg.com/58a81a0d72fdc0ec2700333f/5ae4588e72fdc0a19200871c/2000x.webp?source_format=jpg',
-- 'Product',0);
-- 
-- INSERT INTO products(id,name, unit_price,stock,description,photo_url,class_type,discount)
-- VALUES('好味貓漢堡 經典美式 單一口味 多入',269,10,
-- '無穀超低碳水、豐富水分攝取、堅持新鮮製作，給您的毛小孩最好的照顧。',
-- 'https://shoplineimg.com/58a81a0d72fdc0ec2700333f/5ae459ec8d1db9ddc5009523/2000x.webp?source_format=jpg',
-- 'Product',0);

DROP TABLE IF EXISTS `products_teacher`;
CREATE TABLE `products_teacher` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `unit_price` double NOT NULL,
  `stock` int(10) unsigned NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  `class_type` varchar(45) NOT NULL DEFAULT 'Product',
  `discount` int(2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
USE `VGB`;

INSERT INTO products_teacher (`id`,`name`,`unit_price`,`stock`,`description`,`photo_url`,`class_type`,`discount`) VALUES 
(1,'貓咪的斯巴達清潔整理教室',221,10,'由《我家的貓又在幹怪事了》的人氣畫家卵山玉子老師，以及空間心理顧問伊藤勇司老師聯手合作，以可愛療癒的漫畫，搭配心理層面的簡單解析，了解自己「為什麼無法做好打掃&整理」，只要解決問題、掌握訣竅，就能輕鬆擁有舒適的生活空間！','http://pic.eslite.com/Upload/Product/201807/m/636680181200757500.jpg','Products',0),
(2,'50歲後的斷捨離: 重啟人生整理術(圖解版)',229,10,'「物品」是人生存的證據，居家環境是反射心靈的鏡子。人活得越久，持有的物品數量越多。同樣地，在同一棟房子裡住得越久，經歷的悲歡喜樂、煩惱糾葛也隨之增加。本書匯整作者兩千個以上的案例所獲得的知識、祕訣與心態。並收錄4個常見的家庭範例，規畫出適當的整理方法與步驟。按照本書的指示實踐，必定能獲得心靈與生活都乾脆舒暢的「優質第二人生」！','http://pic.eslite.com/Upload/Product/201807/m/636677591043942452.jpg','Products',0),
(3,'蓬鬆濕潤! 美味司康輕鬆作: 18種口味x10款鹹香變化+11招麵團活用術',306,15,'司康又名英國鬆餅，是英式下午茶中廣受歡迎的點心之一，以其外鬆內軟的特殊口感深受大眾喜愛。本書作者中山真由美在其馳名日本的知名點心工房「chiffon chiffon」內，不定期開設小班制點心教室，相當受到歡迎，基於分享的熱情，她希望透過本書，讓讀者了解司康麵糰變化的樂趣。','http://pic.eslite.com/Upload/Product/201601/m/635885302476661854.jpg','Products',0),
(4,'Pancake Cafe天天鬆餅日! 人氣咖啡館的早午餐提案',216,12,'從大家都熟悉的甜點系鬆餅，到混合了各式各樣配料的鬆餅、鬆餅卷、三明治鬆餅等正餐系鬆餅，提出了非常多到目前為止都沒出現過的全新風格，讓小朋友到大人，不論是女性、男性都能夠愉快享用的美味鬆餅，顛覆你對一般鬆餅的想像！','http://pic.eslite.com/Upload/Product/201406/m/635374674887483750.jpg','Products',0),
(5,'斜槓青年: 全球職涯新趨勢, 迎接更有價值的多職人生',221,16,'共享經濟時代，越來越多人不再滿足於單一職業和身分的束縛，開始選擇一種能夠利用自身專業和才藝，經營多重身分的多職人生。這些人都擁有一個共同的名字：斜槓青年／Slash。','http://pic.eslite.com/Upload/Product/201711/s/636476481610722500.jpg','Products',0),
(6,'你的孩子不是你的孩子: 被考試綁架的家庭故事 一位家教老師的見證(電視劇書衣版)',237,23,'說故事的人，是個證人。她花了七年時間，打開一扇又一扇的大門，走進不同的家庭。在門的背後，她見證了各色光怪陸離的景象：一個每日給兒子準備雞精、維他命的母親，在收到兒子成績單的當下，卻也毫不猶豫地甩出一記耳光；為了安撫雙親，躲在衣櫃裡欺騙別人也傷害自己的兒子；也或許，她看見一種用鈔票堆疊起來的親情⋯⋯她以為她是家教，只需帶給學生知識，沒想到學生及他們的家庭帶給她更多的衝擊。','http://pic.eslite.com/Upload/Product/201806/m/636646485521798750.jpg','Products',0),
(7,'帶孩子到這世界的初衷: 李佳燕醫師的親子門診',253,4,'長期關注教育的李佳燕醫師，本書是她第一本深談自己教育理念的書。她那一顆柔軟如棉的醫者心，讓我們在讀每一個孩子的故事時，心裡也酸楚不已。這些教養真相，或許殘忍，但我們不能不面對。一個堅持為孩子發聲，也將這份允諾，放在自己孩子身上的醫生。','http://pic.eslite.com/Upload/Product/201805/m/636631798720122500.jpg','Products',0),
(8,'原則: 生活和工作 ',474,6,'瑞．達利歐出身美國普通中產家庭，26歲時被投資公司炒魷魚，在自己的兩房公寓室白手起家創辦了橋水，並在接下來超過42年裡，把橋水打造成了獲《財星》（Fortune）雜誌評選為美國第五重要的私人公司。現在橋水管理資金超過1,500億美元，截至2015年年底，盈利超過450億美元。達利歐曾成功預測2008年金融危機，成為華爾街教父級大神。','http://pic.eslite.com/Upload/Product/201803/m/636580356029868750.jpg','Products',0),
(9,'不要在該奮鬥時選擇安逸',205,9,'有了一份糊口的工作，你就不敢奢望更高的工資了嗎？守著一個安穩的職位，你就沒有勇氣跳槽了嗎？穿著Nike爆款，你就感到知足了嗎？看著別人曬iphone、曬旅遊照，你只剩吐槽或按贊的份了嗎？一輩子過著這樣平凡、無趣的生活，就是你這個年紀的終極夢想嗎？','http://pic.eslite.com/Upload/Product/201704/m/636284468947921628.jpg','Products',0),
(10,'脫貧比脫單更重要',237,7,' 再一次寫給廣大年輕世代的「醒腦之書」！直擊功利世界的真實故事，教你認清「金錢」和「顏值」這兩者在現實社會中的定義。同時也拆穿你的焦慮、迷惘、不安、孤獨，是自我情緒勒索，還有你經常缺錢、缺愛、缺顏值的自怨自艾，實際上是你努力不夠、缺乏自律、沒有堅持。老楊的貓頭鷹說：「做人要有底氣，少些戾氣。我沒辦法給你摸摸頭安慰你，我只負責溫柔地打醒你！願你在讀完這本書之後的人生特別有錢，特別走跳，也特別威猛！」','http://pic.eslite.com/Upload/Product/201805/m/636619700385293750.jpg','Products',0),
(11,'你的善良必須有點鋒芒: 36則讓你有態度、不委曲, 深諳世故卻不世故的世道智慧',221,7,'善良，是一種選擇 但善良不該等同妥協或吃虧 缺乏標準的善良 會為難自己，又慣縱了他人 就因為你很善良，底線應該更高 你當善良，且有力量 戳中13億人內心痛點的人生開悟書 在這個趨利的時代，你怎麼定義自己，世界就怎麼對待你','http://pic.eslite.com/Upload/Product/201704/m/636278420455045032.jpg','Products',0),
(12,'情緒勒索: 那些在伴侶、親子、職場間, 最讓人窒息的相處 ',245,6,'6道關鍵練習，擺脫被情緒勒索，重新掌握人生！情緒勒索是一種操控，只會讓彼此的關係崩壞。因為當對方一再屈服與退讓，那是因為懼怕，而不是因為親密、信任與愛。','http://pic.eslite.com/Upload/Product/201712/m/636492925991336250.jpg','Products',0),
(13,'努力多久才可以喊累 ',277,4,'一句安慰，是你最怕的溫柔；一句加油，是你不想承受的重量，不說話，只說故事。心累了，就從她寫的故事裡尋出解答。','http://pic.eslite.com/Upload/Product/201804/m/636598341494960000.jpg','Products',0),
(14,'Kimiko的女性日常美態: 姿勢回正, 自然就瘦了 ',277,2,'百萬Instagram、Facebook、YouTube、微博粉絲追隨 明星御用肢體、舞蹈導師Kimiko，二十餘年觀察與指導上萬學生的體型改善 傾囊相授四個身體重點部位、十二種不同體型的運動與穿搭技巧， 教妳練出優美體線，解救妳的身型危機，找回最適合妳的身型就是美態！','http://pic.eslite.com/Upload/Product/201805/m/636627475500896250.jpg','Products',0),
(15,'靈魂迷宮 (附書迷專屬巴塞隆納追影配件) ',450,7,'薩豐以「遺忘書之墓」系列小說席捲全球書市，銷售逾三千萬冊，並高踞各國暢銷書排行榜，魅力遠勝《哈利波特》和《達文西密碼》。系列四部曲《風之影》《靈魂迷宮》《天使遊戲》《天空的囚徒》沒有特定閱讀順序，四書都是一座巨大文學迷宮的入口，帶領讀者經由不同的途徑與風景，抵達故事核心「遺忘書之墓」，其中又以《風之影》《靈魂迷宮》最受全球讀者矚目。才華洋溢的薩豐，亦親自為系列小說創作配樂並擔綱演奏，引領讀者墜入巴塞隆納街頭的神祕氛圍。 ','http://pic.eslite.com/Upload/Product/201806/m/636645620389298750.jpg','Products',0),
(16,'關於愛與其他的惡魔 ',253,3,'與《百年孤寂》、《愛在瘟疫蔓延時》並列馬奎斯最受歡迎的三大長篇巨作！ 已改編拍成電影《馬奎斯之愛與群魔》','http://pic.eslite.com/Upload/Product/201806/m/636655988894353750.jpg','Products',0),
(17,'卡耐基超強影響力 ',238,6,'對很多人而言，戴爾‧卡耐基這個名字，和長年陪伴讀者改變其人生的暢銷書《人性的弱點》等作品，已可以結為一體。有人認為卡耐基式的人際關係訓練，是由有效的說話課程中自然產生的，其實不然。卡耐基自己也做了以下的說明： 「從一九一二年以來，我為了培養紐約的專業人才，而實施了教育課程。最初我只開闢說話訓練課程，讓課程是透過實際的經驗，在沒有準備的情況下，來思考問題；在生意上，則讓他在沒有準備下與人面談，或者讓他在大眾面前說話，藉此訓練他對自己的想法更有信心、更加沉著。」 ','http://pic.eslite.com/Upload/Product/201808/m/636688819935705000.jpg','Products',0),
(18,'華頓商學院最受歡迎的談判課: 上完這堂課, 世界都會聽你的 (暢銷20萬冊增修版) ',316,18,'每一年，只有最優秀的學生才能進入華頓商學院，當川普、巴菲特和伊隆．馬斯克的校友。史都華．戴蒙教授的談判課，連續20年都是華頓商學院最搶手的課程，他的學生更稱他為「學術界的搖滾巨星」！本書是這堂課的課程菁華。 戴蒙教授強調，無論是要求店家折價100元，還是要求廠商降價1萬元，所使用的談判工具都是一樣的。意思就是，當你學會戴蒙教授的談判技巧，在生活各面向你都能爭取更多！他所教過的3萬個學生都獲得他的真傳，在各行各業如魚得水','http://pic.eslite.com/Upload/Product/201712/m/636487508627787500.jpg','Products',0),
(19,'華頓商學院的高效談判學: 讓你成為最好的談判者! (經典紀念版) ',387,3,'美國賓州大學華頓商學院的湯馬斯‧傑瑞提（Thomas Gerrity）講座教授，專長為法律研究、商業倫理與企業管理。他長年擔任「華頓高階主管談判研訓班」（Wharton Executive Negotiation Workshop）的學術主任，並且與同事共同負責「華頓策略說服研訓班」（Wharton Strategic Persuasion Workshop）。《商業週刊》（Business Week）兩年出版一次的〈最佳商學院指南〉三度將他選為全美最傑出的商學院教授之一；他也多次獲得教學獎。 ','http://pic.eslite.com/Upload/Product/201806/m/636643892185080000.jpg','Products',0),
(20,'連卡內基也佩服的7堂超溫暖說話課: 為何辯才無礙很吃虧? 因為要贏得感情, 你得輸點道理! ',221,4,'為何講道理辯是非，卻傷了多年感情？為何說出真話，卻容易讓人覺得刺耳？為何糖果和鞭子，竟無法激勵人心？為何工作上的忠告，居然變成中傷？為何對方不贊同？為何管理者總得兇？面對話不投機的人，該怎麼溝通才對？如果你有以上煩惱，別擔心！其實，這些問題通通都有解！因為，演講聽眾超過200萬人的暢銷作家山﨑拓巳，集結自身30多年講師、經營者、諮詢顧問的經驗，首次公開獨門的說話技巧。','http://pic.eslite.com/Upload/Product/201802/m/636549096476877500.jpg','Products',0),
(21,'五秒法則: 倒數54321, 衝了! 全球百萬人實證的高效行動法, 根治惰性, 改變人生 ',284,9,'TED最受歡迎演講之一，點閱率超過13,000,000次YouTube、FB、Twitter……全球社群百萬網友實證推薦 Instagram標籤近5萬筆 #5SecondRule 當腦中有個想法， 如何讓自己立刻行動不拖延？ 只要在心中倒數5……4……3……2……1，衝了！ 就能把自己像火箭一樣順利發射出去， 無論什麼目標，屢試不爽！ ','http://pic.eslite.com/Upload/Product/201804/m/636597237487760000.jpg','Products',0),
(22,'人生需要暫停鍵: 從失速的追求中刻意抽離, 與真正的渴望重新對焦 ',300,5,'人生總有些時刻需要抽離日常慣性， 刻意改變行為，才能看清內在渴望。 把暫停當作一種生活方式， 給自己一點空間、一點時間，傾聽內心的聲音。 當你感到心力交瘁，瘋狂運轉卻原地踏步前， 每個人都能避免負循環，重新開始。','http://pic.eslite.com/Upload/Product/201805/m/636625876650115000.jpg','Products',0),
(23,'這個世界, 沒有懷才不遇這件事 ',252,6,'奧里森‧馬登所寫的作品流傳全世界，改變無數人的命運。無論是當時的美國總統艾森豪、尼克森、卡特、布希，還是洛克菲勒、索羅斯、比爾‧蓋茲等商業鉅子在提到他們的成就時，都提到奧里森‧馬登對他們的影響。如果你想被人們重視和重用，獲得肯定和榮譽，不妨現在開始閱讀這本書。 ','http://pic.eslite.com/Upload/Product/201805/m/636632659304341250.jpg','Products',0),
(24,'這份工作, 你真的想做一輩子嗎? 最勵志的轉職指引, 讓你的職涯下半場更加閃亮 ',323,7,'──寫給正為目前工作前景感到迷茫的你──當職涯漸漸邁入下半場，緩慢成長的薪資、一成不變的任務、海市蜃樓的前景，這份工作，你真的想從事一輩子嗎？轉換跑道，真的就能獲得你想要的生活嗎？從熟悉的領域中抽身，真的可能在另一個領域獲得一片天嗎……？當眾多的問號環繞著你，你可以只問自己這麼一句：「如果現在的生活不是你想要的，你願意再為自己做一次選擇嗎？」','http://pic.eslite.com/Upload/Product/201806/m/636659446618292341.jpg','Products',0),
(25,'安靜是種超能力: 寫給內向者的職場進擊指南, 話不多, 但大家都會聽你說 ',300,9,'事覺得你很安靜、老闆覺得你沒想法、家人覺得你沒朋友 內斂、慢熟的人，你可以怎麼做？ ','http://pic.eslite.com/Upload/Product/201807/m/636675858563425000.jpg','Products',0),
(26,'CAN DO工作學: 遇到挑戰先說Yes, 讓今天的壞遭遇變成明天的好故事 ',277,12,'引起無數工作者共鳴的《台版米蘭達的創業筆記》－－網路專欄作家Shannon也面臨過同樣情境，曾跌跌撞撞在行銷傳播領域闖蕩，並在創業的第一個月碰巧懷孕了！面對百廢待興、從零開始的過程，憑著「I CAN DO」的信念，一路過關斬將，從無到有的創造了新品牌和新生命，練就出好好工作、好好生活的職場瑜珈術。','http://pic.eslite.com/Upload/Product/201806/m/636657715382322500.jpg','Products',0),
(27,'在謊言拆穿之前 ',284,8,'讀者大讚！又哭了四次！ 一年內銷售突破20萬冊 ！ 如果能夠回到那一天， 你也會為了最重要的人說謊嗎？ 「回到過去的時間，只到咖啡冷卻為止！」 為心愛的人著想， 所說的四個笨拙而溫柔的「謊言」','http://pic.eslite.com/Upload/Product/201806/m/636638064742790000.jpg','Products',0),
(28,'真確: 扭轉十大直覺偏誤, 發現事情比你想的美好',316,10,'有些事儘管牴觸我們的直覺認知，儘管顯得絕無可能，卻仍然真確。 這本書在談世界，在談世界真正的樣子， 也是在談你，以及你該如何真確思考，基於事實行動。 ','http://pic.eslite.com/Upload/Product/201806/m/636645620212423750.jpg','Products',0),
(29,'後真相時代: 當真相被操弄、利用, 我們該如何看? 如何聽? 如何思考? ',363,17,'「後真相」被牛津辭典選為2016年度代表字彙，並且在英國脫歐和川普當選美國總統時達到高峰。然而「後真相」並非代表這個時代再無真相可信，而是指人們不再重視並思考事件的真實性。 網路時代，資訊唾手可得，大多數人卻寧願窩在舒適圈裡，看著與自己立場相同的新聞，或是輕易就相信了從網路看來、從旁人聽來的種種故事。然後又將這些事件以非黑即白的方式，輕易地評斷劃分。 然而在任何事件、場景、故事中，都存在著「矛盾真相」──述事者從真相的多元面貌中抽出對自己有利的部分，來影響你的態度和行為，進而達到自己的目的──這種真相運作機制，早在潛移默化中改變了你的選擇。','http://pic.eslite.com/Upload/Product/201806/m/636640436602760000.jpg','Products',0),
(30,'何時要從眾? 何時又該特立獨行',300,10,' 華頓商學院教你運用看不見的影響力, 拿捏從眾的最佳時機, 做最好的決定教你運用「看不見的影響力」◎讓你既能從眾，也能特立獨行 在生活與工作上都取得最大的成就！我們為何自認完全不受影響，又總是忍不住想模仿別人？我們為什麼害怕和別人不一樣，卻又自覺應該特立獨行？為什麼我們有時顯得盲從、有時又刻意不去做別人已經在做的事？⋯⋯這一切都來自你看不見的「社會影響力」————它一直都在（只是我們渾然不覺）！','http://pic.eslite.com/Upload/Product/201805/m/636616549382113750.jpg','Products',0);









