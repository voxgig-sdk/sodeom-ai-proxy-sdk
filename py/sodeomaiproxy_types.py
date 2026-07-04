# Typed models for the SodeomAiProxy SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class Ain:
    answer: str


@dataclass
class AinLoadMatch:
    answer: Optional[str] = None


@dataclass
class Ain2:
    answer: str
    message: list
    max_token: Optional[int] = None
    model: Optional[str] = None
    temperature: Optional[float] = None


@dataclass
class Ain2CreateData:
    answer: Optional[str] = None
    max_token: Optional[int] = None
    message: Optional[list] = None
    model: Optional[str] = None
    temperature: Optional[float] = None

