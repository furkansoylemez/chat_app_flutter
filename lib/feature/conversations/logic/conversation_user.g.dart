// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conversationUserHash() => r'844cb38e6ec7bbf6e3d6498b2cd17cc3fb2a53e5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef ConversationUserRef
    = AutoDisposeStreamProviderRef<DocumentSnapshot<Object?>>;

/// See also [conversationUser].
@ProviderFor(conversationUser)
const conversationUserProvider = ConversationUserFamily();

/// See also [conversationUser].
class ConversationUserFamily
    extends Family<AsyncValue<DocumentSnapshot<Object?>>> {
  /// See also [conversationUser].
  const ConversationUserFamily();

  /// See also [conversationUser].
  ConversationUserProvider call(
    String otherUserId,
  ) {
    return ConversationUserProvider(
      otherUserId,
    );
  }

  @override
  ConversationUserProvider getProviderOverride(
    covariant ConversationUserProvider provider,
  ) {
    return call(
      provider.otherUserId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'conversationUserProvider';
}

/// See also [conversationUser].
class ConversationUserProvider
    extends AutoDisposeStreamProvider<DocumentSnapshot<Object?>> {
  /// See also [conversationUser].
  ConversationUserProvider(
    this.otherUserId,
  ) : super.internal(
          (ref) => conversationUser(
            ref,
            otherUserId,
          ),
          from: conversationUserProvider,
          name: r'conversationUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conversationUserHash,
          dependencies: ConversationUserFamily._dependencies,
          allTransitiveDependencies:
              ConversationUserFamily._allTransitiveDependencies,
        );

  final String otherUserId;

  @override
  bool operator ==(Object other) {
    return other is ConversationUserProvider &&
        other.otherUserId == otherUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, otherUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
