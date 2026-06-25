import '../../../model/hero_config.dart';
import 'portfolio_base_controller.dart';

mixin PortfolioConfigMixin on PortfolioBaseController {
  Future<void> loadHero() async {
    try {
      isHeroLoading.value = true;
      if (heroConfig.value.title.isEmpty) {
        heroConfig.value = HeroConfig.defaults();
      }
      heroConfig.value = await svc.getHeroConfig();
    } finally {
      isHeroLoading.value = false;
    }
  }

  Future<void> loadSocial() async {
    socialConfig.value = await svc.getSocialConfig();
  }

  Future<void> loadContact() async {
    contactConfig.value = await svc.getContactConfig();
  }

  Future<void> loadCta() async {
    ctaConfig.value = await svc.getCtaConfig();
  }

  void refreshHero() => loadHero();
  void refreshSocial() => loadSocial();
  void refreshContact() => loadContact();
  void refreshCta() => loadCta();
}
