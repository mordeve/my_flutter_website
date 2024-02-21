'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "ab612a92a03658f3048bce7f1f18788e",
"index.html": "71cf59f2cf0f031bded8111bae6e82ba",
"/": "71cf59f2cf0f031bded8111bae6e82ba",
"main.dart.js": "183dcee573c11e9aeaa4bfc5e511ee9d",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "905dd89eaedb591f3d75c3d801799ed1",
"icons/Icon-192.png": "938150b9586046bb4a32f50ec90883c1",
"icons/Icon-maskable-192.png": "938150b9586046bb4a32f50ec90883c1",
"icons/loading.gif": "e3c9a3fbb6c1fe8c254da7e3188dfc44",
"icons/Icon-maskable-512.png": "991465ad08824eca46c4872b5fe33ec5",
"icons/Icon-512.png": "991465ad08824eca46c4872b5fe33ec5",
"manifest.json": "a8710f2b59899cc3286c7f1f4dd269ba",
"assets/AssetManifest.json": "b89fa04923d93ee6a6ce0db48256be66",
"assets/NOTICES": "856a6bc004876c52c85f9a4211af3fa6",
"assets/FontManifest.json": "68fbc8946fc8abd9861c43bea2abd3cb",
"assets/AssetManifest.bin.json": "2f1a4dce1e2b99dae337376b25f3cf02",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "d58b9506f37ce9b8dc9f5411b912465d",
"assets/fonts/MaterialIcons-Regular.otf": "d8718d1dfeaac3edc8c6bc37262e8840",
"assets/assets/icon.png": "58dc71afb6c57adada712e03e5687bdb",
"assets/assets/bg_dugun.png": "f179a306bbc88a3075839f05f4898d2a",
"assets/assets/icon.jpg": "962482c296b7ce74d77dae876cb85409",
"assets/assets/bg2.jpeg": "d93a75caf1dbe0d1c371266e3abdaeed",
"assets/assets/bg_kina.png": "1233fcf882a5464d70f83e433b01a8c5",
"assets/assets/bg_kina.jpg": "35eaada4f32091add9e5392b0d5b17f8",
"assets/assets/bg_kina_3.png": "8adf661560905d86e1e445cde9ee6a5f",
"assets/assets/d11.png": "6e1ddb6a626bf6f042f5f6b84a81bf3d",
"assets/assets/bg1.png": "417e3fe34f6661a0d2427e368bedbd02",
"assets/assets/bg1.jpg": "8166b6f16303f3b588810f33ef08ec66",
"assets/assets/main_bg.png": "c50c2c367e260745bb6513f230237e63",
"assets/assets/bg3.jpg": "814d05c752ee59cc3437bb5685c8870c",
"assets/assets/bg_kina_4.png": "c0be89a513e33516f799f471ef926527",
"assets/assets/bg_nikah.png": "baa491bca7a462260198165e3866184e",
"assets/assets/fonts/Pacifico/Pacifico-Regular.ttf": "85bb2d0ec4a0da159de42e89089ccc0b",
"assets/assets/2.png": "aa9afc138b7f1221ba89c02698f7e90f",
"assets/assets/3.png": "e22f4f8703c1acdd83ad5a540cc85f5b",
"assets/assets/1.png": "97d71fdca5d4cf19ee7de0d62e4c55bb",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
