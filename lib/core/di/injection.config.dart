// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:home1/core/di/register_module.dart' as _i716;
import 'package:home1/core/service/storage_service/storage_service.dart'
    as _i497;
import 'package:home1/core/service/storage_service/storage_service_impl.dart'
    as _i627;
import 'package:home1/features/news/data/remote/api/news_data_source.dart'
    as _i498;
import 'package:home1/features/news/data/remote/impl/news_data_source_impl.dart'
    as _i839;
import 'package:home1/features/news/data/repo_impl/news_repository_impl.dart'
    as _i220;
import 'package:home1/features/news/domain/repo/news_repository.dart' as _i800;
import 'package:home1/features/news/ui/bloc/news_bloc.dart' as _i595;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i460.SharedPreferencesAsync>(() => registerModule.prefs);
    gh.lazySingleton<_i497.StorageService>(
      () => _i627.StorageServiceImpl(gh<_i460.SharedPreferencesAsync>()),
    );
    gh.lazySingleton<_i498.NewsDataSource>(
      () => _i839.NewsDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i800.NewsRepository>(
      () => _i220.NewsRepositoryImpl(dataSource: gh<_i498.NewsDataSource>()),
    );
    gh.factory<_i595.NewsBloc>(
      () => _i595.NewsBloc(repository: gh<_i800.NewsRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i716.RegisterModule {}
