'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "c8c8081201b16359f6b5e94b0bafb6aa",
".git/config": "cf17e1fa7a06791d10ed84b36f125447",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "b09414c3358903fe2e1cc55eba29344b",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "03df9c9680b4316079ed606d12795649",
".git/logs/refs/heads/main": "c863efff0d66e9ad1eb6819218b2d965",
".git/logs/refs/remotes/origin/main": "a1bf1df3d126c1d110f09ccc9874ed71",
".git/objects/00/559eeb290fb8036f10633ff0640447d827b27c": "7fbd4486d5ea862eb2c1d2a07b06b395",
".git/objects/01/e0f6feb6a36b8724eb235b5cdf1121329a6cc6": "7d306cd87f9a80f09f9d72c5618f1be4",
".git/objects/01/ea6116881f688ee68b0d35297daff09f7204f0": "dcbba4db0245a61475f46f2e07d7fc42",
".git/objects/06/f5020f8dfcd3f9848f7f04909ef753f50e9fd6": "c81780a47e9482fe72f5a62180fa12a3",
".git/objects/07/0f3c756ca4bc34fc6f038b00bd9d02a2f883f2": "7b13d701fa90e2f2afdf8c26eb25d4b5",
".git/objects/0a/75b5a7c27a4be17ec717d1b4a3a9ad05193962": "350bdf05fd3f97cfa6476c80fdcbe392",
".git/objects/0b/420a0d3fac33c1f9a1fca1ada851e497e8085e": "c32fbffc76cbe8238a72508c23a5f311",
".git/objects/0f/c344c7e8b9e32ea1ad91f30ded22556352d7bf": "a8a30f28869f7378465338066f34d80d",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/1b/4507619c49fa1ee549d34f6623e3b28aafcae2": "843ec165d81746def7fe7127f68a2626",
".git/objects/1c/4f448c0d66353e7d747be716584a6581ddeda3": "ac17351eee9d68344570db46bf9bc93c",
".git/objects/1e/3cd97176808cfe9ea60dc99ea54de0849b4f9b": "cc8ec6ca97d0d222ffa24a2e03f78925",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/24/6c8c61426fb811c860105baacb15ca7b92889d": "654e012cf3cfb0e4a0bf1ee8d4d44a66",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/objects/25/d6e3ca66ba820dc4848a1f2ff38ea69dd0e77e": "f0b6e073ba0095a1435a495da9d6c3a2",
".git/objects/27/3ccb159189e18f5b5dee07eabbef6bfd9320ea": "c53a2036738917b7360cdd5e441acc8f",
".git/objects/2d/4689d04390df177739c0a2369e36aee9f0aad7": "d16ed32fffb8bb1fc15f6b7cf442ecfb",
".git/objects/36/4209d3b43761a8a813d36ca403b6667d59a93c": "29ad74191a76de4ece9afd7180790206",
".git/objects/3a/9553b6fdf60d3777e8c3954fd265ce99d125f0": "e01174dc8783e0554978d181e67018e7",
".git/objects/3d/c08cde5d3ffcd173d0e5dd68e2a102c5883b07": "85c6babd539c89e54ad26cc55bf5b147",
".git/objects/40/b48f38ea7a3a59cca3b7d8c958b9830e563f12": "2cec96b0087e20b8e1fc2f897908b116",
".git/objects/41/b58c2c307f9cb7bc56f551744316cbc789082e": "41d115bfffa623197c7afa30afe1ec49",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/50/fc13f56440c875714256d14eeb26eae86076f1": "4f35827abfebab5bded3846a1e840ac0",
".git/objects/52/8ebb341c7ab024d4364be81e5396e976ccf8ad": "0121160ba573e25d1d631014f91cd621",
".git/objects/54/d829967590eb287d70bf21c3b627d465a5e23d": "e9de5bef71209ec8d7bfa44aa5def5c8",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/5a/88c1b56508fe3a95d3bbe587c467cbdbfff6fa": "40720d27bfb68d4e3f05a0544faacefb",
".git/objects/62/c89ee094658c7a9465824fdb42793a64ea557b": "133cd5da638f245b079d9e9cdc29ae38",
".git/objects/65/439c09a9acb0cb6c9c136208bf340355397df5": "5d321e5711d43bc15384ed141e8816d3",
".git/objects/68/8ff9ca554c7f5219e69d4e5f5a6f9360ace8c7": "25bceaadb8af5e56223e2dccb988d34b",
".git/objects/6b/cdcc27f22e001e46defdfd9e23f224ff65dd67": "624b5324c1f5198f7f6ede95410d5b7b",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/79/43e51d211b0cd991550a1ff5b3b294420346b6": "c65e205d73f85cfae326f9a06e95769b",
".git/objects/7f/6525345bb50019a030e5153c65ab0c06f3665a": "7093f3f7069cf6d2377370109fb2d032",
".git/objects/7f/b221ea9f3cc5c55bcdbcfc3b4434bd3fbec154": "81245063ac79bb0964b94efefb69497d",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8d/85be191b3f5a137779f137f6f745856cdce142": "da681bbdc5bb31b943c48b02635087f0",
".git/objects/8e/1913056165061019ceb09992acf86e1912bb64": "e9ecc8d2d341c55aebffc690dc49c0e1",
".git/objects/91/8a4b86d046d5baeaede06ad5d0e6a12828c6d5": "8585f63bc8181acfa715fcb4af8d05c5",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/95/eff805e6da6f24dbefd011c8de9ed01847e577": "7433004db6ccf9032a91495ea7197ed0",
".git/objects/99/fea7b7d78acba5ddb995ed337dfb182d340bcd": "66cef2af5c0f89e9378d43c94abd1c70",
".git/objects/a9/67bc69dfa646b18a0e6c3cc6ac50998de9e63d": "891f30d7c75ca05f1a362ff4ad9eb076",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b4/88c2e20d271d0831009590932d0dc9a6a10f34": "4fce65c79a45f6ac08a9388ae6c73071",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/c0/9d06bb6adcba0191efeb967bc2d5d886d93095": "24713a054fa60ba9ab21c71009769b1a",
".git/objects/c3/942894cb317d047e374f50ceadd77684c7058a": "061f50b7108c8cf9fd2fed7a7d500a68",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/c9/c23311137ecb81d00041d72caa42cb2a1a437d": "30016a514fb16c91d7ca85d16e6d1882",
".git/objects/cf/463e609fb008261e67ef48f8d0abb7d0e34f00": "418de3d55c2ff66e460720b1983b1b00",
".git/objects/d0/47cfb00cad32976fb0d4f1e9090cfe14305727": "54f8eb265bdb12e9098a9fc844ece1fd",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d4/e1c2c39c84d89b9f0d6c9fd218c6eb93d65181": "c9df6a45454029867ca110b40ece80d1",
".git/objects/d6/586d7edee3fce3e01cb754400ec288237cc6b8": "70b9c0f4de914860a8f75877b7383b9b",
".git/objects/d6/91f1cdaff8d3749e7ba413d52b103133c7c7c8": "7fcee970d80a3450945f4105262883b0",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d9/c92d479ece68a7b696e760685622d0b3a1cb01": "5c3fc5ee2bbc1fa0384db1bf6770997a",
".git/objects/da/2cba4ed011d70c0f55e8781994fa07d1f16512": "39fb7b1b28868994bb066271e6d366f1",
".git/objects/db/497448b7fea6e3cae8f56976796c1b031c8eff": "6645dbc2180932899f4fbff7f98e09e7",
".git/objects/df/0d27e03555d8bfdcb9fb7652efc07ffdab5038": "40755b11b7c2c57b5e5b9f64b0a1d6f8",
".git/objects/df/25829e38cb92d2b5936539e1f490da2b83632a": "2b68d5846d8ddc2f21d36cdb89ee2969",
".git/objects/e1/d1349fea5576709fa2b3b8b5dedc7104770935": "22d83fc0f8c56c4f180ffc9afdd1ce4f",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/e7/1132328cdc11e492c8d0745d64e8e92a266a8e": "9ae4fcfb0d3c32b3095bd7b56768ec11",
".git/objects/e8/1b9740f89c068476c76bf039c04f65ba5d9490": "2832f3441fe20f7181d3c689bf2b6e16",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/fe/b923193313be2c33af92df86fc627fc96aa89c": "48d3914d107178d5a36ac94eb3d8b760",
".git/objects/fe/d81bc77e6aa54f8092995af83a00215c807b62": "f669a6d91ed6cb580cef8ca74d5ff405",
".git/refs/heads/main": "8f0a09c1b89520a160201458964261e2",
".git/refs/remotes/origin/main": "8f0a09c1b89520a160201458964261e2",
"assets/AssetManifest.bin": "663274cff7993e2962a6e11eaddc6720",
"assets/AssetManifest.bin.json": "5f7a41e31d8fc21d5edf8f5569cd10a9",
"assets/AssetManifest.json": "00a8f91be3123bcb7e384be9b6916555",
"assets/assets/images/ange.jpg": "10a8a4f59904a7c5fb05e5c1f6a65ec4",
"assets/assets/images/anim.json": "caae7647b9b199416ba56e28c6f64909",
"assets/assets/images/bg.jpg": "7efac04d44b8b6b6c18aea4db4580a3c",
"assets/assets/images/bg2.jpg": "76a5ef567b1d43d1b7e25f8ef602807f",
"assets/assets/images/birthday_icon.png": "5d7edd081b08f6b350d70735585224c8",
"assets/assets/images/chat.png": "7ec320c82b10b60a0c8de3b5f61146ec",
"assets/assets/images/chat_icon.png": "107580cfb3814649d9587ad5647787b7",
"assets/assets/images/checked_icon.png": "71bbacab4fb1d9dc141d4d350fbba530",
"assets/assets/images/doc.json": "a5fd65cc3c4589fdfbce334a2c90e03a",
"assets/assets/images/home_icon.png": "f8415c24c7a647ce6cf155c029ef2557",
"assets/assets/images/inscription.jpg": "30d23583e9f277c2a0960da9bf897feb",
"assets/assets/images/login.jpg": "0bffcb19f8a8c3fc7c19ebc9168ae3c4",
"assets/assets/images/login.json": "fb32db124372d64e14be6c9d1fd5c5bd",
"assets/assets/images/money-icon.png": "3c93805586add7a023024bddf7164376",
"assets/assets/images/more_icon.png": "e74a7f33af6b9860b36228e6b49d6a43",
"assets/assets/images/news_icon.png": "a961956b2baa1c6639bcb67248687c42",
"assets/assets/images/notif_icon.png": "ac1e770731560eaa5e8c7ff11af450ea",
"assets/assets/images/oups.jpg": "3d03bd1651012c1fb43bcc594da2a879",
"assets/assets/images/people_icon.png": "c1b57fc6840c9e37951ed3b38a6565cd",
"assets/assets/images/planning_icon.png": "7e83b7511acf5e2ccf692bf9f6b005ee",
"assets/assets/images/presence_icon.png": "4a8c42469741665d98c403d13f7d8232",
"assets/assets/images/reload_icon.png": "5dd01bfaab7d59f84d034ea6c0c7013b",
"assets/assets/images/sc.json": "6abd47a884bdbbaa02aa0f97827f1252",
"assets/assets/images2e830691": "a961956b2baa1c6639bcb67248687c42",
"assets/assets/images2ecfe942": "30d23583e9f277c2a0960da9bf897feb",
"assets/assets/images3f6e9e24": "7efac04d44b8b6b6c18aea4db4580a3c",
"assets/assets/images5042abbc": "caae7647b9b199416ba56e28c6f64909",
"assets/assets/images681972cf": "71bbacab4fb1d9dc141d4d350fbba530",
"assets/assets/images70f9efe6": "5dd01bfaab7d59f84d034ea6c0c7013b",
"assets/assets/images71f527fd": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/images932751fa": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/images9d67e572": "c1b57fc6840c9e37951ed3b38a6565cd",
"assets/assets/imagesb87c7fc8": "5d7edd081b08f6b350d70735585224c8",
"assets/assets/imagesc415c46": "e74a7f33af6b9860b36228e6b49d6a43",
"assets/assets/imagesd2c3ba5c": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/imagesd68cfd55": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/imagesf05e5bd6": "0bffcb19f8a8c3fc7c19ebc9168ae3c4",
"assets/assets/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/FontManifest.json": "7aa85efeefcbb69d11e562978a5d323d",
"assets/fonts/MaterialIcons-Regular.otf": "5353319418b8c188a5f7276eab3a6d99",
"assets/NOTICES": "519cbc78b35f9223f7b3dc52e313e871",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "4c4e151d2cef54abb1e838358cd9deb2",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "840e83e3249796364f7c61126f0af80c",
"/": "840e83e3249796364f7c61126f0af80c",
"main.dart.js": "99df6b139bc5d1f6eeef0cd678bb4208",
"manifest.json": "c91dbe104f927d25f6d321df4cbd1bf8",
"version.json": "3399850228d50f6726c948c7f41a3fcd"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
