'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "cfdb9563b2ea1d36383d7e4bf1a02ff9",
"/": "cfdb9563b2ea1d36383d7e4bf1a02ff9",
"version.json": "ab612a92a03658f3048bce7f1f18788e",
"favicon.png": "905dd89eaedb591f3d75c3d801799ed1",
"assets/AssetManifest.bin": "d58b9506f37ce9b8dc9f5411b912465d",
"assets/FontManifest.json": "68fbc8946fc8abd9861c43bea2abd3cb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/fonts/MaterialIcons-Regular.otf": "d8718d1dfeaac3edc8c6bc37262e8840",
"assets/assets/d11.png": "6e1ddb6a626bf6f042f5f6b84a81bf3d",
"assets/assets/bg1.png": "417e3fe34f6661a0d2427e368bedbd02",
"assets/assets/fonts/Pacifico/Pacifico-Regular.ttf": "85bb2d0ec4a0da159de42e89089ccc0b",
"assets/assets/1.png": "97d71fdca5d4cf19ee7de0d62e4c55bb",
"assets/assets/main_bg.png": "c50c2c367e260745bb6513f230237e63",
"assets/assets/bg2.jpeg": "d93a75caf1dbe0d1c371266e3abdaeed",
"assets/assets/bg1.jpg": "8166b6f16303f3b588810f33ef08ec66",
"assets/assets/bg_kina.png": "1233fcf882a5464d70f83e433b01a8c5",
"assets/assets/bg_kina.jpg": "35eaada4f32091add9e5392b0d5b17f8",
"assets/assets/bg_dugun.png": "f179a306bbc88a3075839f05f4898d2a",
"assets/assets/icon.jpg": "962482c296b7ce74d77dae876cb85409",
"assets/assets/3.png": "e22f4f8703c1acdd83ad5a540cc85f5b",
"assets/assets/bg_kina_4.png": "c0be89a513e33516f799f471ef926527",
"assets/assets/icon.png": "58dc71afb6c57adada712e03e5687bdb",
"assets/assets/2.png": "aa9afc138b7f1221ba89c02698f7e90f",
"assets/assets/bg3.jpg": "814d05c752ee59cc3437bb5685c8870c",
"assets/assets/bg_kina_3.png": "8adf661560905d86e1e445cde9ee6a5f",
"assets/assets/bg_nikah.png": "baa491bca7a462260198165e3866184e",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/NOTICES": "e93bb04fa2df14a56a0887362db290cb",
"assets/AssetManifest.json": "b89fa04923d93ee6a6ce0db48256be66",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"manifest.json": "a8710f2b59899cc3286c7f1f4dd269ba",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"icons/Icon-maskable-512.png": "991465ad08824eca46c4872b5fe33ec5",
"icons/Icon-maskable-192.png": "938150b9586046bb4a32f50ec90883c1",
"icons/Icon-512.png": "991465ad08824eca46c4872b5fe33ec5",
"icons/Icon-192.png": "938150b9586046bb4a32f50ec90883c1",
"icons/loading.gif": "e3c9a3fbb6c1fe8c254da7e3188dfc44",
"main.dart.js": "6248a0af1eeaec9bce08e619f375a88b"};
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
