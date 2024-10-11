'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ea79d8147da85557f20d1c9190448273",
"assets/AssetManifest.bin.json": "75baf0dcb01b1cb1e1a36c75a04355db",
"assets/AssetManifest.json": "35aca31c1f14c3ca7e1ab87ecde5b960",
"assets/assets/images/ange.jpg": "10a8a4f59904a7c5fb05e5c1f6a65ec4",
"assets/assets/images/anim.json": "caae7647b9b199416ba56e28c6f64909",
"assets/assets/images/bg.jpg": "7efac04d44b8b6b6c18aea4db4580a3c",
"assets/assets/images/bg2.jpg": "76a5ef567b1d43d1b7e25f8ef602807f",
"assets/assets/images/birthday_icon.png": "5d7edd081b08f6b350d70735585224c8",
"assets/assets/images/chat.png": "7ec320c82b10b60a0c8de3b5f61146ec",
"assets/assets/images/chat_icon.png": "107580cfb3814649d9587ad5647787b7",
"assets/assets/images/checked_icon.png": "71bbacab4fb1d9dc141d4d350fbba530",
"assets/assets/images/doc.json": "a5fd65cc3c4589fdfbce334a2c90e03a",
"assets/assets/images/doc2.json": "8622029a84680c48e131f9e33c902b95",
"assets/assets/images/home_icon.png": "f8415c24c7a647ce6cf155c029ef2557",
"assets/assets/images/inscription.jpg": "30d23583e9f277c2a0960da9bf897feb",
"assets/assets/images/login.jpg": "0bffcb19f8a8c3fc7c19ebc9168ae3c4",
"assets/assets/images/login.json": "fb32db124372d64e14be6c9d1fd5c5bd",
"assets/assets/images/money-icon.png": "3c93805586add7a023024bddf7164376",
"assets/assets/images/more_icon.png": "e74a7f33af6b9860b36228e6b49d6a43",
"assets/assets/images/news_icon.png": "a961956b2baa1c6639bcb67248687c42",
"assets/assets/images/notif_icon.png": "ac1e770731560eaa5e8c7ff11af450ea",
"assets/assets/images/oups.jpg": "3d03bd1651012c1fb43bcc594da2a879",
"assets/assets/images/p.png": "26be119165413b62dd22ea3bd1b65414",
"assets/assets/images/people_icon.png": "c1b57fc6840c9e37951ed3b38a6565cd",
"assets/assets/images/pharmacie.png": "3350417bbac7c182010fe486946f9f4a",
"assets/assets/images/planning_icon.png": "7e83b7511acf5e2ccf692bf9f6b005ee",
"assets/assets/images/presence_icon.png": "4a8c42469741665d98c403d13f7d8232",
"assets/assets/images/reload_icon.png": "5dd01bfaab7d59f84d034ea6c0c7013b",
"assets/assets/images/sc.json": "6abd47a884bdbbaa02aa0f97827f1252",
"assets/assets/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/FontManifest.json": "7aa85efeefcbb69d11e562978a5d323d",
"assets/fonts/MaterialIcons-Regular.otf": "2158ceb8d734082abae940121c886e98",
"assets/NOTICES": "0189f35f4438be66be44ece71cf31942",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "7292df3bfc79c744349bd5ba0f1bc7d3",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "cf203dea87bb01c77a7da86df3a84432",
"/": "cf203dea87bb01c77a7da86df3a84432",
"main.dart.js": "8158e53d89e430be94ebe4550c61c947",
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
