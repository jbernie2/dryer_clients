{
  bigdecimal = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "00db5v09k1z3539g1zrk7vkjrln9967k08adh6qx33ng97a2gg5w";
      type = "gem";
    };
    version = "3.1.6";
  };
  concurrent-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1qh1b14jwbbj242klkyz5fc7npd4j0mvndz62gajhvl1l3wd7zc2";
      type = "gem";
    };
    version = "1.2.3";
  };
  debug = {
    dependencies = ["irb" "reline"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1npzlgpvvms97gw0ixndapnvwy7ih3zc5r3s3wd4y64rlbaadwc6";
      type = "gem";
    };
    version = "1.9.1";
  };
  diff-lcs = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1znxccz83m4xgpd239nyqxlifdb7m8rlfayk6s259186nkgj6ci7";
      type = "gem";
    };
    version = "1.5.1";
  };
  dry-configurable = {
    dependencies = ["dry-core" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1nmp5yr7ry85ckxrfbccllcqy4kky9yshvggyygvkcg4rp7ljx6x";
      type = "gem";
    };
    version = "1.1.0";
  };
  dry-core = {
    dependencies = ["concurrent-ruby" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "03a5qn74c4lk2rpy6wlhv66synjlyzc4wn086xzphkpmw12l4bzk";
      type = "gem";
    };
    version = "1.0.1";
  };
  dry-inflector = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "09hnvna3lg2x36li63988kv664d0zvy7y0z33803yvrdr9hj7lka";
      type = "gem";
    };
    version = "1.0.0";
  };
  dry-initializer = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1v3dah1r96b10m8xjixmdmymg7dr16wn5715id4vxjkw6vm7s9jd";
      type = "gem";
    };
    version = "3.1.1";
  };
  dry-logic = {
    dependencies = ["concurrent-ruby" "dry-core" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "05nldkc154r0qzlhss7n5klfiyyz05x2fkq08y13s34py6023vcr";
      type = "gem";
    };
    version = "1.5.0";
  };
  dry-monads = {
    dependencies = ["concurrent-ruby" "dry-core" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "06sh48d13gyb2lascfd5g2pyf1qxzinydgb0ir81kbwga3zqj0rv";
      type = "gem";
    };
    version = "1.6.0";
  };
  dry-schema = {
    dependencies = ["concurrent-ruby" "dry-configurable" "dry-core" "dry-initializer" "dry-logic" "dry-types" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1qwk2d1wn3ykp1pn43qc2y5w4s5amkfjd52z2ivdnvcqqx3wh3pz";
      type = "gem";
    };
    version = "1.13.3";
  };
  dry-types = {
    dependencies = ["bigdecimal" "concurrent-ruby" "dry-core" "dry-inflector" "dry-logic" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0sn4n13jj8x27n07yv2s7zp0c5cdlwsbh21laqm5f7ikhp10y67z";
      type = "gem";
    };
    version = "1.7.2";
  };
  dry-validation = {
    dependencies = ["concurrent-ruby" "dry-core" "dry-initializer" "dry-schema" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1b7aik6bmnpi956qfigkidi5wd5c8xw3wgghah7mfwlpc9szsaim";
      type = "gem";
    };
    version = "1.10.0";
  };
  dryer_clients = {
    dependencies = ["dry-validation" "dryer_services" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      path = ./.;
      type = "path";
    };
    version = "0.0.0";
  };
  dryer_services = {
    dependencies = ["dry-monads"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1v9wn7lkbmsqdrwap39nyf9n5n5ncghkkc5gcva0v8np8p25dfqn";
      type = "gem";
    };
    version = "2.0.0";
  };
  io-console = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "08d2lx42pa8jjav0lcjbzfzmw61b8imxr9041pva8xzqabrczp7h";
      type = "gem";
    };
    version = "0.7.2";
  };
  irb = {
    dependencies = ["rdoc" "reline"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1f8wms39b7z83x6pflq2sjh3sikpk0xjh680igbpkp1j3pl0fpx0";
      type = "gem";
    };
    version = "1.11.2";
  };
  psych = {
    dependencies = ["stringio"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0s5383m6004q76xm3lb732bp4sjzb6mxb6rbgn129gy2izsj4wrk";
      type = "gem";
    };
    version = "5.1.2";
  };
  rdoc = {
    dependencies = ["psych"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "14wnrpd1kl43ynk1wwwgv9avsw84d1lrvlfyrjy3d4h7h7ndnqzp";
      type = "gem";
    };
    version = "6.6.2";
  };
  reline = {
    dependencies = ["io-console"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0fhwdmw89zqb1fdxcd6lr57zabbfi08z8j6kqwngak0xnxi2j10l";
      type = "gem";
    };
    version = "0.4.2";
  };
  rspec = {
    dependencies = ["rspec-core" "rspec-expectations" "rspec-mocks"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "14xrp8vq6i9zx37vh0yp4h9m0anx9paw200l1r5ad9fmq559346l";
      type = "gem";
    };
    version = "3.13.0";
  };
  rspec-core = {
    dependencies = ["rspec-support"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0k252n7s80bvjvpskgfm285a3djjjqyjcarlh3aq7a4dx2s94xsm";
      type = "gem";
    };
    version = "3.13.0";
  };
  rspec-expectations = {
    dependencies = ["diff-lcs" "rspec-support"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0bhhjzwdk96vf3gq3rs7mln80q27fhq82hda3r15byb24b34h7b2";
      type = "gem";
    };
    version = "3.13.0";
  };
  rspec-mocks = {
    dependencies = ["diff-lcs" "rspec-support"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0rkzkcfk2x0qjr5fxw6ib4wpjy0hqbziywplnp6pg3bm2l98jnkk";
      type = "gem";
    };
    version = "3.13.0";
  };
  rspec-support = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0msjfw99dkbvmviv3wsid4k9h1prdgq7pnm52dcyf362p19mywhf";
      type = "gem";
    };
    version = "3.13.0";
  };
  stringio = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "063psvsn1aq6digpznxfranhcpmi0sdv2jhra5g0459sw0x2dxn1";
      type = "gem";
    };
    version = "3.1.0";
  };
  zeitwerk = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1m67qmsak3x8ixs8rb971azl3l7wapri65pmbf5z886h46q63f1d";
      type = "gem";
    };
    version = "2.6.13";
  };
}
