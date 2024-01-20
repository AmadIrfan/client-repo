'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a8b13f3b4bed947c38685f6650bd2560",
"assets/AssetManifest.bin.json": "7427302ab2202df8788a9a51849ed3a1",
"assets/AssetManifest.json": "1b17a587d55f9b1c762ae963a527d143",
"assets/assets/dashboard/category.png": "b16ccff1507843630fc5c8043895aa30",
"assets/assets/dashboard/dark_profile.png": "7b182ac6804d0619a34e369cad5eed39",
"assets/assets/dashboard/home.png": "36940598ec21900a6f2f7b694770ceb7",
"assets/assets/dashboard/key.png": "9a3c5e2d818f610faa066eaed7bcb55f",
"assets/assets/dashboard/log-out-circle.png": "08778b37f509124ee7ea86cf4e20425c",
"assets/assets/dashboard/profile.png": "019ec34298bb8273583444299531f5a8",
"assets/assets/dashboard/question-mark.png": "991d3e0a7919a6edb3bfed4ecda29f34",
"assets/assets/dashboard/users.png": "b2ed2d200a3f5e4d8fffc97fe8f0f4c1",
"assets/assets/icons/dark.png": "ef184464e2d828b2145ca2d24af641a1",
"assets/assets/icons/delete.png": "13f39e8420bd0cad9a0788457bdfca45",
"assets/assets/icons/Documents.svg": "51896b51d35e28711cf4bd218bde185d",
"assets/assets/icons/doc_file.svg": "552a02a5a3dbaee682de14573f0ca9f3",
"assets/assets/icons/drop_box.svg": "3295157e194179743d6093de9f1ff254",
"assets/assets/icons/edit.png": "633bb94207fd46c426fcd4d2c24d03ba",
"assets/assets/icons/excle_file.svg": "dc91b258ecf87f5731fb2ab9ae15a3ec",
"assets/assets/icons/Figma_file.svg": "0ae328b79325e7615054aed3147c81f9",
"assets/assets/icons/folder.svg": "40a82e74e930ac73aa6ccb85d8c5a29c",
"assets/assets/icons/google_drive.svg": "9a3005a58d47a11bfeffc11ddd3567c1",
"assets/assets/icons/hello.png": "f6eed70935905251ba7d48ff239c8e81",
"assets/assets/icons/light.png": "08ae431ce613281d6ba91a38afa926b3",
"assets/assets/icons/logo.png": "7b304e442dd3ee69eecf3f00cf95c302",
"assets/assets/icons/logo.svg": "b3af0c077a73709c992d7e075b76ce33",
"assets/assets/icons/mask1.png": "bf9f627c07a8c29a983c64e49cb964f8",
"assets/assets/icons/mask2.png": "33134099db18d75bfd70fa41edaf03df",
"assets/assets/icons/mask3.png": "475786a1c28a3937635f0e0cf459b8f0",
"assets/assets/icons/media.svg": "059dfe46bd2d92e30bf361c2f7055c3b",
"assets/assets/icons/media_file.svg": "2ac15c968f8a8cea571a0f3e9f238a66",
"assets/assets/icons/menu_dashbord.svg": "b2cdf62e9ce9ca35f3fc72f1c1fcc7d4",
"assets/assets/icons/menu_doc.svg": "09673c2879de2db9646345011dbaa7bb",
"assets/assets/icons/menu_notification.svg": "460268d6e4bdeab56538d7020cc4b326",
"assets/assets/icons/menu_profile.svg": "fe56f998a7c1b307809ea3653a1b62f9",
"assets/assets/icons/menu_setting.svg": "d0e24d5d0956729e0e2ab09cb4327e32",
"assets/assets/icons/menu_store.svg": "2fd4ae47fd0fca084e50a600dda008cd",
"assets/assets/icons/menu_task.svg": "1a02d1c14f49a765da34487d23a3093b",
"assets/assets/icons/menu_tran.svg": "6c95fa7ae6679737dc57efd2ccbb0e57",
"assets/assets/icons/one_drive.svg": "aa908c0a29eb795606799385cdfc8592",
"assets/assets/icons/pdf_file.svg": "ca854643eeee7bedba7a1d550e2ba94f",
"assets/assets/icons/Search.svg": "396d519c18918ed763d741f4ba90243a",
"assets/assets/icons/sound_file.svg": "fe212d5edfddd0786319edf50601ec73",
"assets/assets/icons/unknown.svg": "b2f3cdc507252d75dea079282f14614f",
"assets/assets/icons/xd_file.svg": "38913b108e39bcd55988050d2d80194c",
"assets/assets/images/101%2520(1).png": "5ca500650f417ce08bb3b1ffda6ee81a",
"assets/assets/images/101.png": "284707037759e80ce5e783017b8058be",
"assets/assets/images/693.jpg": "7a4ab24b90403852fc26c99406e4b0a5",
"assets/assets/images/6931.png": "5605c26d77fa3bcbe28127cffe8ac725",
"assets/assets/images/add%2520category.svg": "6c9fc84692e932985a8935fbdba2f0ab",
"assets/assets/images/Add%2520Question.svg": "ecec9610c9997e3eb367d226d3ae9496",
"assets/assets/images/admin_illustrator.png": "aa64467a0a6883c71a8b8276291f5ed4",
"assets/assets/images/Category.svg": "ca34a25517d998998ff8fc292d69eaac",
"assets/assets/images/Change%2520password.svg": "7b826ad781a79286d540bc44e4866f21",
"assets/assets/images/Dashbord.svg": "bcdc4a231209ee8ce4999a61dab22852",
"assets/assets/images/dot.png": "2642e53193bc5990a80a4f2b3db20d6c",
"assets/assets/images/gif_3.gif": "79fd37625e514af40142cddb2fa89e8e",
"assets/assets/images/growth-graph.png": "6dcad22cf78869c0e0798913e80d598c",
"assets/assets/images/ic_close.png": "3c1d20eadbe70cf98e636a88b689f20d",
"assets/assets/images/logo.png": "128e30cc061e49f503f48c338a21380e",
"assets/assets/images/logout.svg": "048fd0194dc043a1d72b5a5f82131d68",
"assets/assets/images/next.png": "fa1b852d436de5420dfff4053397db05",
"assets/assets/images/preview.png": "06f8adfa9655a11886e583892f2b1b6d",
"assets/assets/images/profile.png": "febd67d2d75ef53d38ae4a308b1fd8da",
"assets/assets/images/profile_pic.png": "5f56c3070f1c066ae15ecad12fb44f54",
"assets/assets/images/right.png": "14d974a8ca0f2cd9818375ec8de64259",
"assets/assets/images/skipped.png": "dd46ef7955b2df67e7ffceed9b51de33",
"assets/assets/images/user.png": "aa0ba04d7b5c534acbcf55de2dd51b85",
"assets/assets/images/user.svg": "1a063370cf1ac5d73f58b6346efa0396",
"assets/FontManifest.json": "0d76cc62b4b0fd549b655a2cacc82f71",
"assets/fonts/MaterialIcons-Regular.otf": "715e134e15bfb56d22d43250f450ffa9",
"assets/fonts/OpenSans-Bold.ttf": "ff615c954fc5485fb3757516721b41ff",
"assets/fonts/OpenSans-BoldItalic.ttf": "f288e82f90d27a27ba22a4c0561896f8",
"assets/fonts/OpenSans-ExtraBold.ttf": "8fd58ae86936600201df265f1112a014",
"assets/fonts/OpenSans-ExtraBoldItalic.ttf": "7f86cc2636f0adadc0dec52009c0545f",
"assets/fonts/OpenSans-Italic.ttf": "90f74e681980c2ef280a3d24006e5b35",
"assets/fonts/OpenSans-Light.ttf": "0652ba43f7a92220fbc18a5519fbf2c1",
"assets/fonts/OpenSans-LightItalic.ttf": "c0d0b7abb91323f27be4a42269f31ef1",
"assets/fonts/OpenSans-Medium.ttf": "7a56b1bba54be9caf32f096d8224a492",
"assets/fonts/OpenSans-MediumItalic.ttf": "7e93c9a251c09d9984721aeb3bd8f976",
"assets/fonts/OpenSans-Regular.ttf": "58b1f440729d267697bddcddb994bce9",
"assets/fonts/OpenSans-SemiBold.ttf": "984b9097c910bf2f182889707e2e4cbe",
"assets/fonts/OpenSans-SemiBoldItalic.ttf": "d94afe8b2ccf8210aac58024276bcc06",
"assets/NOTICES": "5dcc068308c15854d10179da1bdd56fc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/fluttertoast/assets/toastify.css": "910ddaaf9712a0b0392cf7975a3b7fb5",
"assets/packages/fluttertoast/assets/toastify.js": "18cfdd77033aa55d215e8a78c090ba89",
"assets/packages/flutter_vector_icons/fonts/AntDesign.ttf": "3a2ba31570920eeb9b1d217cabe58315",
"assets/packages/flutter_vector_icons/fonts/Entypo.ttf": "31b5ffea3daddc69dd01a1f3d6cf63c5",
"assets/packages/flutter_vector_icons/fonts/EvilIcons.ttf": "140c53a7643ea949007aa9a282153849",
"assets/packages/flutter_vector_icons/fonts/Feather.ttf": "a76d309774d33d9856f650bed4292a23",
"assets/packages/flutter_vector_icons/fonts/FontAwesome.ttf": "b06871f281fee6b241d60582ae9369b9",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Brands.ttf": "3b89dd103490708d19a95adcae52210e",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Regular.ttf": "1f77739ca9ff2188b539c36f30ffa2be",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Solid.ttf": "605ed7926cf39a2ad5ec2d1f9d391d3d",
"assets/packages/flutter_vector_icons/fonts/Fontisto.ttf": "b49ae8ab2dbccb02c4d11caaacf09eab",
"assets/packages/flutter_vector_icons/fonts/Foundation.ttf": "e20945d7c929279ef7a6f1db184a4470",
"assets/packages/flutter_vector_icons/fonts/Ionicons.ttf": "b3263095df30cb7db78c613e73f9499a",
"assets/packages/flutter_vector_icons/fonts/MaterialCommunityIcons.ttf": "b62641afc9ab487008e996a5c5865e56",
"assets/packages/flutter_vector_icons/fonts/MaterialIcons.ttf": "8ef52a15e44481b41e7db3c7eaf9bb83",
"assets/packages/flutter_vector_icons/fonts/Octicons.ttf": "f7c53c47a66934504fcbc7cc164895a7",
"assets/packages/flutter_vector_icons/fonts/SimpleLineIcons.ttf": "d2285965fe34b05465047401b8595dd0",
"assets/packages/flutter_vector_icons/fonts/Zocial.ttf": "1681f34aaca71b8dfb70756bca331eb2",
"assets/packages/nb_utils/fonts/LineAwesome.ttf": "4fe1928e582fd2e3316275954fc92e86",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "b8e5e5bf2b490d3576a9562f24395532",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "acdd567faa403388649e37ceb9adeb44",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "9df2d386e62f5cb47fb2de6672c693fb",
"/": "9df2d386e62f5cb47fb2de6672c693fb",
"main.dart.js": "d4e18be3741a54d581e9ae3b0af487d5",
"manifest.json": "9334be9782cd73f9fd015a262ffc8a9d",
"version.json": "68c64e6755784b6354d29f6094f16df4"};
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
